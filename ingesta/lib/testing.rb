def ask_for_sheet_in_spreadsheet(ss)
  puts "¿En qué hoja se encuentra la base de datos?"
  last = 0;
  ss.sheets.each_with_index do |sheet, index|
    puts "[#{index+1}] #{sheet}"
    last = index+1;
  end

  $stdout << "Elija un número del 1 al #{last}: "
  opt = $stdin.gets.strip

  unless opt =~ /^\d+$/
    puts ''
    puts "<#{opt}> no es una opción válida, intente nuevamente.\n\n"
    return ask_for_sheet_in_spreadsheet(ss)
  end

  opt = opt.to_i

  begin
    ss.sheets[opt]
  rescue Exception
    return ask_for_sheet_in_spreadsheet(ss)
  end

  return opt-1
end