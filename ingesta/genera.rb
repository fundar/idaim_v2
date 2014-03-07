#!/usr/bin/env ruby
# encoding: utf-8

require 'json'
require 'fileutils'
require_relative './lib/estados'

$data = JSON.parse(File.open(ARGV[0]).read, symbolize_names: true)
$outDir = File.expand_path(ARGV[1], Dir.pwd)


def guarda nombre, data
  fname = "#{$outDir}/#{nombre}.json"
  FileUtils.mkdir_p File.dirname(fname)
  File.open(fname, 'w+') do |f|
    f << data.to_json
  end
end


def calificacion_por_entidad entidad
  h = {
    t: 0,  #total
    e: {}, #ejes
    i: {}, #indicadores
    c: {}  #criterios
  }
  h[:c] = $data[:porEstado].values[entidad]
  
  last = 0;
  c = h[:c].values
  $data[:indicadores].each do |index, indicador|
    qty = indicador[:criterios]
    slice = c.slice(last, qty)
    h[:i][indicador[:index]] = (slice.inject(:+).to_f/qty.to_f*100).round
    last += qty
  end

  last = 0;
  sum = 0;
  $data[:ejes].each do |index, eje|
    qty = eje[:criterios].count
    slice = c.slice(last,qty)
    pc = slice.inject(:+).to_f/qty.to_f
    sum += pc;
    h[:e][index] = (pc*100).round
    last += qty
  end

  h[:t] = (sum*100/h[:e].length.to_f).round

  h
end


nombres = {
  ejes: {
    1 => 'Positivación',
    2 => 'Diseño institucional',
    3 => 'Proceso de acceso y obligaciones de transparencia'
  },
  indicadores: Hash[$data[:indicadores].map { |index, indicador| [index, indicador[:nombre]] }],
  criterios: Hash[$data[:criterios].map { |criterio| [criterio[:index], criterio[:nombre]] }],
}

e = []
$data[:ejes].each do |eje, d|
  indicadores = d[:indicadores].map do |indicador|
    c = $data[:criterios].select {|crit| crit[:indicador].to_s == indicador.to_s}.map {|crit| crit[:index]}
    {i: indicador, c: c}
  end
  e.push({
    e: eje,
    i: indicadores,
  })
end

guarda :estructura, e
exit;

guarda :nombres, nombres

#federal = $data[:estados].index 'fed'

estados = {}
nacional = {
  total: {},
  ejes: {}
}

$data[:estados].each_with_index do |edo, index|
  data = calificacion_por_entidad(index)
  puts "#{index} - #{edo}: "+data[:e].values.join(',')
  guarda "estados/#{Estados.iso(edo)}", data
  estados[index] = Estados.paraCodigoInterno(edo)

  nacional[:total][index] = data[:t]
  data[:e].each do |key, eje|
    nacional[:ejes][key] = nacional[:ejes][key] || {}
    nacional[:ejes][key][index] = eje
  end
end

guarda :estados, estados

guarda :nacional, nacional