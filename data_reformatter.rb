def read_and_format(line, output, entry_date)
  return nil if line.strip.empty?
  
  if ( (/\d{4}\/\d{2}\/\d{2}/).match(line[0...10]) )
    return line[0...10]
  elsif entry_date 
    if (line.split("\t").size == 3)
      output.write("\r\n#{entry_date} ")
      output.write(line.gsub("\n", '').gsub("\r", '').gsub("\t", '#!%'))
    else
      output.write(" #{line}".gsub("\n", '').gsub("\r", ''))
    end
  end
  return entry_date

end

def reformat input_path
  output = File.open('output/data.txt', 'w')

  File.open(input_path, 'r') do |file|

    entry_date = nil
    lines = file.each_line do |line|
      entry_date = read_and_format(line, output, entry_date)
    end
  end
  
  output.close
end

reformat 'input/line_data.txt'
