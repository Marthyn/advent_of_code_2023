require '../day_3/processor'

file = File.open('verify_input.txt')
input = file.read

map = Map.new(input)
puts map.all_numbers_with_symbols
puts map.all_numbers_with_symbols.sum(&:integer)

file = File.open('input.txt')
input = file.read

puts input.chars.uniq

map = Map.new(input)
puts map.all_numbers_with_symbols
puts map.all_numbers_with_symbols.sum(&:integer)
