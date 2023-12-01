require '../day_1/processor'

file = File.open('verify_input.txt')

input = file.read

puts calculate(input)
puts calculate(input).sum == 142 # Success

file = File.open('input.txt')

input = file.read

puts calculate(input)
puts calculate(input).sum == 55538 # Success