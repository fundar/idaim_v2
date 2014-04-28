#!/usr/bin/env ruby
# encoding: utf-8

# Generador de archivos JSON para IDAIM
# 
# USAGE: ./genera.rb data.json /path/to/output
# Este script toma los datos generados por `parse.rb` y
# los separa y procesa a sus archivos separados 
# 
# @author Partido Surrealista Mexicano
# @version 1.0

require 'json'
require 'fileutils'
require_relative './lib/estados'

$data = JSON.parse(File.open(ARGV[0]).read, symbolize_names: true)
$outDir = File.expand_path(ARGV[1], Dir.pwd)

# --
# Funciones
# --

# Guarda un archivo
# 
# @param [Symbol,String] El nombre del archivo
# @param [Hash,Array] Los datos a convertir a JSON
def guarda nombre, data
  fname = "#{$outDir}/#{nombre}.json"
  puts "Creando #{fname}"
  FileUtils.mkdir_p File.dirname(fname)
  File.open(fname, 'w+') do |f|
    f << data.to_json
  end
end

# La valoración por eje, indicador y criterio de una entidad
# 
# @param [Integer] El índice de la entidad 
def calificacion_por_entidad entidad
  h = {
    t: 0,  #total
    e: {}, #ejes
    i: {}, #indicadores
    c: {}  #criterios
  }
  # Los valores de los criterios por estado
  h[:c] = $data[:porEstado].values[entidad]
  
  last = 0;
  c = h[:c].values
  # Los valores de los indicadores por estado
  $data[:indicadores].each do |index, indicador|
    qty = indicador[:criterios]
    slice = c.slice(last, qty)
    h[:i][indicador[:index]] = (slice.inject(:+).to_f/qty.to_f*100).floor
    last += qty
  end

  last = 0;
  sum = 0;
  # Los valores de los ejes por estado
  $data[:ejes].each do |index, eje|
    qty = eje[:criterios].count
    slice = c.slice(last,qty)
    pc = slice.inject(:+).to_f/qty.to_f
    sum += pc;
    h[:e][index] = (pc*100).floor
    last += qty
  end

  # La calificación total
  h[:t] = (sum*100/h[:e].length.to_f).round

  h
end

# nombres.json
nombres = {
  eje: {
    1 => 'Positivación',
    2 => 'Diseño institucional',
    3 => 'Proceso de acceso y obligaciones de transparencia'
  },
  indicador: Hash[$data[:indicadores].map { |index, indicador| [index, indicador[:nombre]] }],
  criterio: Hash[$data[:criterios].map { |criterio| [criterio[:index], criterio[:nombre]] }],
}

e = []
# estructura.json
$data[:ejes].each do |eje, d|
  indicadores = d[:indicadores].map do |indicador|
    c = $data[:criterios].select {|crit| crit[:indicador].to_s == indicador.to_s}.map {|crit| {id: crit[:index]} }
    {id: indicador, children: c}
  end
  e.push({
    id: eje,
    children: indicadores,
  })
end

guarda :estructura, e
guarda :nombres, nombres

estados = {}
nacional = {
  total: {},
  ejes: {},
}

# lista interina para poder asignar posiciones
edos = {}
top = {
  e: {},
  i: {}
}

# estados/{estado}.json
$data[:estados].each_with_index do |edo, index|
  data = calificacion_por_entidad(index)
  
  # Array post-procesable para sacar posiciones
  edos[edo] = {iso: Estados.iso(edo), data: data}
  
  estados[index] = Estados.paraCodigoInterno(edo)

  # nacional.json
  nacional[:total][index] = data[:t]
  data[:e].each do |key, eje|
    nacional[:ejes][key] = nacional[:ejes][key] || {}
    nacional[:ejes][key][index] = eje
    unless index == 32
      top[:e][key] ||= []
      top[:e][key] << {edo: index, cal: eje}
    end
  end

  next if index == 32
  data[:i].each do |key, indicador|
    top[:i][key] ||= []
    top[:i][key] << {edo: index, cal: indicador}
  end
end

# Empieza posicionamiento
edosClean = edos.dup
edosClean.delete :fed
listaEstados = Hash[edosClean.map {|id, estado|
  [id, estado[:data][:t]]
}]

listaEstados.sort_by {|k,v| v}.reverse.each_with_index do |estado, index|
  edos[estado[0]][:data][:pos] = index+1
end

maxmin = {
  e: {},
  i: {}
}

topIntermedio = {
  e: {},
  i: {}
}


top[:e].each do |key, eje|
  topIntermedio[:e][key] = eje.sort_by {|v| v[:cal]}
end

top[:i] = top[:i].each do |key, indicador|
  topIntermedio[:i][key] = indicador.sort_by {|v| v[:cal]}
end


topIntermedio[:e].each do |k, e|
  maxmin[:e][k] = {max: e.last, min: e.first}
end

topIntermedio[:i].each do |k, i|
  maxmin[:i][k] = {max: i.last, min: i.first}
end

guarda :"top", maxmin


# Termina posicionamiento

edos.each do |key, edo|
  guarda :"estados/#{edo[:iso]}", edo[:data]
end

guarda :estados, estados
guarda :nacional, nacional