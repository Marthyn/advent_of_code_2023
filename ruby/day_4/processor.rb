require 'pry'

class Scratcher
  attr_reader :no, :winning_numbers, :participant_numbers

  MATCHER = /Card\s+([0-9]+):/.freeze
  def initialize(line)
    @no = line.match(MATCHER).captures.first.to_i
    numbers = line.gsub(MATCHER, '')

    winning_numbers, participant_numbers = numbers.strip.split('|')
    @winning_numbers = winning_numbers.split(' ').map(&:to_i)
    @participant_numbers = participant_numbers.split(' ').map(&:to_i)
  end

  def matches
    participant_numbers & winning_numbers
  end

  def score
    return 0 if matches == []

    1 * 2 ** (matches.count - 1)
  end

  def to_s
    "Card #{no}: #{winning_numbers.join(' ')} | #{participant_numbers.join(' ')} | Score: #{score} | Matches: #{matches.count}"
  end
end

class List
  attr_reader :scratchers

  def initialize(input)
    @scratchers = input.lines.map { |line| Scratcher.new(line) }
  end

  def score
    scratchers.sum(&:score)
  end
end