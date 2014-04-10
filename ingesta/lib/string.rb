# encoding: utf-8
# 
# Limpieza de strings
# 
# @author Partido Surrealista Mexicano
# @version 1.0

class String

  # Limpia un string
  # 
  # # Quita espaciado doble, así como al principio y final de una línea
  def clean!
    self.strip!
    self.gsub!(/\s+/, ' ')
    self  
  end

  # Regresa una copia limpia de un string
  # 
  # @see #clean!
  def clean
    self.dup.clean!
  end

end