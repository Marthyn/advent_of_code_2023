require 'pry'
class Entry
  attr_reader :character, :x, :y

  SYMBOLS = %w[* + & = $ @ / - % #].freeze

  def initialize(character, x, y)
    @character = character
    @x = x
    @y = y
  end

  def symbol?
    SYMBOLS.include?(character)
  end

  def location
    [x, y]
  end

  def to_s
    "#{character} @ #{x}, #{y}"
  end
end

class Number
  attr_reader :integer

  def initialize(integer, location_sets)
    @location_sets = location_sets
    @integer = integer
  end

  def signature
    "#{integer}:#{@location_sets.map {|x, y| "#{x},#{y};"}}"
  end

  def to_s
    signature
  end
end

class Map
  attr_reader :entries

  def initialize(input)
    @entries = []

    input.lines.each_with_index do |line, y|
      line.chars.each_with_index do |character, x|
        @entries << Entry.new(character, x, y)
      end
    end
  end

  def symbol_locations
    entries.select(&:symbol?)
  end

  def character_at(x, y)
    entries.find { |entry| entry.x == x && entry.y == y }&.character
  end

  def find_full_number(x, y)
    left = x
    right = x
    left_edge = character_at(x, y)
    right_edge = character_at(x, y)

    while !left_edge.nil? && left_edge.match?(/[0-9]/)
      left -= 1
      left_edge = character_at(left, y)
    end

    while !right_edge.nil? && right_edge.match?(/[0-9]/)
      right += 1
      right_edge = character_at(right, y)
    end

    characters = []
    locations = []

    ((left + 1)..(right - 1)).each do |new_x|
      characters << character_at(new_x, y)
      locations << [new_x , y]
    end

    Number.new(characters.join.to_i, locations)
  end

  def all_numbers_with_symbols
    adjecent_to_symbol_locations_with_numbers.uniq.map do |x, y|
      find_full_number(x, y)
    end.uniq(&:signature)
  end

  def adjecent_to_symbol_locations_with_numbers
    @adjecent_to_symbol_locations_with_numbers = []
    symbol_locations.each do |symbol|
      right = [symbol.x + 1, symbol.y]
      left = [symbol.x - 1, symbol.y]
      top = [symbol.x, symbol.y - 1]
      bottom = [symbol.x, symbol.y + 1]
      bottom_right = [symbol.x + 1, symbol.y + 1]
      bottom_left = [symbol.x - 1, symbol.y + 1]
      top_right = [symbol.x + 1, symbol.y - 1]
      top_left = [symbol.x - 1, symbol.y - 1]

      valid_positions = [right, left, top, bottom, bottom_right, bottom_left, top_right, top_left].reject { |x, y| x.negative? || y.negative? }

      valid_positions.each do |x, y|
        if character_at(x, y).match?(/[0-9]/)
          @adjecent_to_symbol_locations_with_numbers << [x, y]
        end
      end
    end
    @adjecent_to_symbol_locations_with_numbers
  end
end