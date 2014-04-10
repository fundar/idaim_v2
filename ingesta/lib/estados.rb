# encoding: utf-8
# 
# Conversiones entre los estados de Excel y nombres ISO
# 
# @author Partido Surrealista Mexicano
# @version 1.0

module Estados

  # La tabla de traducciones
  TABLA = {
    ags:  {i: "agu", n: "Aguascalientes" },
    bc:   {i: "bcn", n: "Baja California" },
    bcs:  {i: "bcs", n: "Baja California Sur" },
    camp: {i: "cam", n: "Campeche" },
    chis: {i: "chp", n: "Chiapas" },
    chih: {i: "chh", n: "Chihuahua" },
    coah: {i: "coa", n: "Coahuila" },
    col:  {i: "col", n: "Colima" },
    df:   {i: "dif", n: "Distrito Federal" },
    dgo:  {i: "dur", n: "Durango" },
    emex: {i: "mex", n: "Estado de México" },
    gto:  {i: "gua", n: "Guanajuato" },
    gro:  {i: "gro", n: "Guerrero" },
    hgo:  {i: "hid", n: "Hidalgo" },
    jal:  {i: "jal", n: "Jalisco" },
    mich: {i: "mic", n: "Michoacán" },
    mor:  {i: "mor", n: "Morelos" },
    nay:  {i: "nay", n: "Nayarit" },
    nl:   {i: "nle", n: "Nuevo León" },
    oax:  {i: "oax", n: "Oaxaca" },
    pue:  {i: "pue", n: "Puebla" },
    qro:  {i: "que", n: "Querétaro" },
    qroo: {i: "roo", n: "Quintana Roo" },
    slp:  {i: "slp", n: "San Luis Potosí" },
    sin:  {i: "sin", n: "Sinaloa" },
    son:  {i: "son", n: "Sonora" },
    tabs: {i: "tab", n: "Tabasco" },
    tamps:{i: "tam", n: "Tamaulipas" },
    tlax: {i: "tla", n: "Tlaxcala" },
    ver:  {i: "ver", n: "Veracruz" },
    yuc:  {i: "yuc", n: "Yucatán" },
    zac:  {i: "zac", n: "Zacatecas" },
    fed:  {i: "nal", n: "Nacional" }
  }

  # Convierte de codigo interno a ISO
  # 
  # @param interno [String] El código de Excel
  # @return [String] El código ISO
  def self.iso interno
    self.paraCodigoInterno(interno)[:i]
  end

  # Convierte codigo interno a Nombre de estado
  # 
  # @param interno [String] El código interno
  # @return [String] El nombre del estado
  def self.nombre interno
    self.paraCodigoInterno(interno)[:n]
  end

  # Regresa la tabla completa para el código interno
  # 
  # @param interno [String] El código interno
  # @return [Hash] La tabla con propiedades `i` y `n`, código ISO y nombre respectivamente
  def self.paraCodigoInterno interno
    Estados::TABLA[interno.to_sym]
  end
end