require '../day_3/processor'

file = File.open('verify_input.txt')
input = file.read

map = Map.new(input)
pp map.adjecent_to_symbol_locations_with_numbers
pp map.all_numbers_with_symbols
pp map.all_numbers_with_symbols.sum

file = File.open('input.txt')
input = file.read

map = Map.new(input)
pp map.adjecent_to_symbol_locations_with_numbers
pp map.all_numbers_with_symbols
pp map.all_numbers_with_symbols.sum
