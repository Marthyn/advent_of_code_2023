require 'pry'

def calculate(input)
  input.lines.map do |line|
    numbers = line.delete('^0-9')

    first, last = [numbers[0], numbers[-1]]
    "#{first}#{last}".to_i
  end
end

