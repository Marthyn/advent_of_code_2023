require 'pry'

NUMBERS = {
  one: '1',
  two: '2',
  three: '3',
  four: '4',
  five: '5',
  six: '6',
  seven: '7',
  eight: '8',
  nine: '9'
}.freeze

def calculate(input)
  input.lines.map do |line|
    numbers = find_numbers(line)

    [numbers[0], numbers[-1]].join.to_i
  end
end

def find_numbers(line)
  max_value = line.length - 1
  numbers = []
  start = 0
  while start < max_value
    (start..max_value).each do |take|
      word = line[start..take]
      if NUMBERS.keys.include?(word.to_sym)
        numbers << NUMBERS[word.to_sym]
      elsif number = NUMBERS.values.find { |n| n == word }
        numbers << number
      end
    end
    start += 1
  end
  numbers
end

