# encoding: utf-8
# 
# OptionParser para parser de datos
# 
# @author Partido Surrealista Mexicano
# @version 1.0

def get_opts
  pwd = Dir.pwd
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Uso: ./parse.rb [opciones] archivo.xlsx"
    opts.on( '-h', '--help', 'Muestra esta pantalla' ) do
      puts opts
      exit
    end
    
    options[:sheet] = nil
    opts.on( '-s hoja', '--sheet hoja', "La hoja del documento que usaremos" ) do |hoja|
      options[:sheet] = hoja.to_i-1
    end

    opts.on '-o dir', '--output dir', "El directorio de salida de los datos" do |dir|
      if File.directory? File.expand_path(dir, pwd)
        options[:dir] = dir
      else
        puts "#{dir} no es un directorio"
        exit 255
      end
      
    end
    
    if !ARGV[0]
      puts opts.help()
      exit 255
    end
    
  end.parse!
  options
end
