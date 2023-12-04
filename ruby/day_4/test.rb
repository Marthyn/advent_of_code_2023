require '../day_4/processor'

file = File.open('verify_input.txt')
input = file.read

list = List.new(input)

pp list.scratchers.map(&:to_s)
pp list.score

file = File.open('input.txt')
input = file.read

list = List.new(input)
pp list.scratchers.map(&:to_s)
pp list.score