require '../day_1/processor'

file = File.open('verify_input_2.txt')

input = file.read

calculate(input)
puts calculate(input).sum == 281 # Success


file = File.open('input.txt')

input = file.read

calculate(input)
puts calculate(input).sum == 54875 # Success