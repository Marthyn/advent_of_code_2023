require 'pry'

class Combo
  attr_reader :amount, :color

  def initialize(amount, color)
    @amount = amount.to_i
    @color = color
  end

  def to_s
    "#{amount} #{color}"
  end
end

class Grab
  attr_reader :combos

  AVAILABLES = {
    'red' => 12,
    'blue' => 14,
    'green' => 13
  }.freeze

  def initialize(combos)
    @combos = combos
  end

  def possible?
    combos.all? do |combo|
      combo.amount <= AVAILABLES[combo.color]
    end
  end
end

class Round
  attr_reader :grabs, :number

  MATCHER = /Game ([0-9]+):/.freeze

  AVAILABLES = {
    'red' => 12,
    'blue' => 14,
    'green' => 13
  }.freeze

  def initialize(string)
    @grabs = []
    @number = string.match(MATCHER).captures.first.to_i
    grabs = string.sub(MATCHER, '').strip.split(';')

    grabs.each do |dice|
      @combos = []
      combos = dice.strip.split(',')
      combos.each do |combo|
        amount, color = combo.split(' ')
        @combos << Combo.new(amount, color)
      end
      @grabs << Grab.new(@combos)
    end
  end

  def min_needed_combos
    min = {
      'red' => 0,
      'blue' => 0,
      'green' => 0
    }

    grabs.each do |grab|
      grab.combos.each do |combo|
        min[combo.color] += 1 while combo.amount > min[combo.color]
      end
    end

    min
  end

  def power
    min_needed_combos.values.reject(&:zero?).inject(:*)
  end

  def possible?
    grabs.all?(&:possible?)
  end
end

class Game
  attr_reader :rounds

  def initialize(input)
    @rounds = []

    input.lines do |line|
      @rounds << Round.new(line)
    end
  end

  def possible_rounds
    rounds.select(&:possible?)
  end

  def min_needed_power
    rounds.sum(&:power)
  end

  def winning_sum
    possible_rounds.sum(&:number)
  end
end

