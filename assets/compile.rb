#!/usr/bin/env ruby

require 'sass'
require 'listen'
require_relative 'assets'

absPath = File.dirname(File.expand_path File.dirname(__FILE__))
$root = "#{absPath}/assets"
$dst = "#{absPath}/public"

Assets.root $root

def save path, contents
  File.open(path, 'w+') do |f|
    f << contents
  end
end

listener = Listen.to("#{$root}", debug: true) do |mod, add, del|
  
  del.each do |f|
    res = Assets.delete f
    res.each do |path, info|
      p = "#{$dst}#{info[:relative_path]}"
      puts "DEL: #{p}"
      #File.unlink p if info[:contents]
      #save p, info[:result]
    end
  end

  mod.each do |f|
    res = Assets.modify f
    res.each do |path, info|
      p = "#{$dst}#{info[:relative_path]}"
      puts "MOD: #{p}"
      save p, info[:result]
    end
  end

  add.each do |f|
    res = Assets.add f
    res.each do |path, info|
      p = "#{$dst}#{info[:relative_path]}"
      puts "ADD: #{p}"
      save p, info[:result]
    end
  end

end
listener.start

sleep