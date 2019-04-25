# frozen_string_literal: true

def write_to_output(line, output, entry_date)
  if line.split("\t").size == 3
    output.write("\r\n#{entry_date} ")
    output.write(line.delete("\n").delete("\r").gsub("\t", '#!%'))
  else
    output.write(" #{line}".delete("\n").delete("\r"))
  end
end

def read_and_format(line, entry_date, output)
  return nil if line.strip.empty?
  return line[0...10] if %r{\d{4}/\d{2}/\d{2}}.match?(line[0...10])

  write_to_output(line, output, entry_date) if entry_date

  entry_date
end

def reformat(input_path)
  output = File.open('output/data.txt', 'w')

  File.open(input_path, 'r') do |file|
    entry_date = nil
    file.each_line do |line|
      entry_date = read_and_format(line, entry_date, output)
    end
  end

  output.close
end

reformat 'input/line_data.txt'
