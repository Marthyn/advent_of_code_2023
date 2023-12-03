require '../day_2/processor'

file = File.open('verify_input.txt')

input = file.read

game = Game.new(input)
puts game.winning_sum
puts game.min_needed_power

file = File.open('input.txt')

input = file.read

game = Game.new(input)
puts game.winning_sum
puts game.min_needed_power
