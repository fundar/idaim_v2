#!/usr/bin/env ruby
# encoding: utf-8
# 
# Generador de archivos JSON para IDAIM
# 
# USAGE: ./genera.rb -s [número de hoja] basededatos.xslx
# Esta rutina sólo extrae datos y los peina para después
# ser procesados por `genera.rb`
# 
# @author Partido Surrealista Mexicano
# @version 1.0

require 'rubygems'
require 'bundler/setup'
require 'roo'
require 'optparse'
require 'fileutils'
require 'json'
require_relative 'lib/sheet'
require_relative 'lib/options'
require_relative 'lib/string'

options = get_opts

# Tomamos como único argumento el path al archivo de Excel
file = File.expand_path(ARGV[0], Dir.pwd)
ss = Roo::Spreadsheet.open(file)

# Si no hay más que una hoja, leámos esta
if (ss.sheets.count == 1)
  options[:sheet] = 0
end

# De lo contrario, preguntamos
options[:sheet] = ask_for_sheet_in_spreadsheet(ss) unless (options[:sheet])

estados = []
ss.default_sheet = ss.sheets[options[:sheet]]

# Iteramos para sacar los estados
(5..37).each do |col|
  estados << ss.cell(1, col).downcase
end

# E inicializamos todas las variables que leeremos
indicadores = {}
criterios = []
ejes = {}
eje_actual = 1

# Las celdas "vacías", que en realidad estan merged
skips = []
# Los saltos entre eje y eje
breaks = []
# Si estoy saltando esta celda
saltando = false

# Expresión para detectar un indicador
indicador_match = /^(\d+)\./

# Leyendo todas las filas
0.upto(ss.last_row) do |row|
  cell = ss.cell(row,1)

  is_blank = cell.to_s.strip == ''
  is_indicador = cell =~ indicador_match
  
  breaks << row if is_indicador or (!is_blank and !is_indicador and !saltando)
  skips << row unless is_indicador and !is_blank
  saltando = (is_blank or is_indicador) ? false : true
end

# El primer break no sirve de nada
breaks.shift
saltando = false

# Por cada par consecutivo de <breaks>
breaks.each_cons(2) do |start, ends|
  cell = ss.cell(start,1)
  unless cell =~ indicador_match
    eje_actual +=1 unless saltando
    saltando = true
    next
  end

  saltando = false
  index = cell.match(indicador_match)[0].to_i
  i = {
    nombre: cell.gsub(/\d+\.\s*/, '').clean!,
    index: index,
    criterios: 0,
    eje: eje_actual
  }

  ejes[eje_actual] = ejes[eje_actual] || {indicadores: [], criterios: []}
  ejes[eje_actual][:indicadores] << index

  
  indicadores[index] = i

  (start..ends-1).each do |c|
    crit = ss.cell(c, 'D')
    index_criterio = crit.match(indicador_match)[0].to_i
    criterios << {nombre: crit.gsub(/\d+\.\s*/, '').clean!, indicador: index, row: c, index: index_criterio}
    ejes[eje_actual][:criterios] << index_criterio
  end

end

porEstado = {
  criterios: {},
  indicadores: {}
}

criterios.each do |criterio|
  # pa los cálculos
  indicadores[criterio[:indicador]][:criterios] += 1

  (5..37).each do |col|
    edo_index = col-5
    val = ss.cell(criterio[:row], col)
    porEstado[:criterios][edo_index] = porEstado[:criterios][edo_index] || {}
    porEstado[:criterios][edo_index][criterio[:index]] = val.to_i
  end
  criterio.delete :row
end

data = {
  ejes: ejes,
  indicadores: indicadores,
  criterios: criterios,
  porEstado: porEstado[:criterios],
  estados: estados
}

puts "Encontré #{ejes.length} ejes, #{indicadores.length} indicadores y #{criterios.length} criterios para #{estados.count} entidades"


str = data.to_json

# Guardamos por default los datos en ./data
options[:output] = File.expand_path('./data', Dir.pwd) unless options[:output]

puts "Guardando datos en #{options[:output]}/consolidado.json..."

# Guardamos todo
FileUtils.mkdir_p options[:output]
File.open("#{options[:output]}/consolidado.json", 'w+') do |f|
  f << str
end
puts "Listo"