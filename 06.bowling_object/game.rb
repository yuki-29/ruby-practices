# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  def initialize(scores)
    shots = scores.split(',').map { |score| Shot.new(score) }

    @frames = Array.new(10) do |i|
      if i == 9
        Frame.new(shots, last: true)
      else
        length = shots[0].strike? ? 1 : 2
        Frame.new(shots.shift(length), frame_count: i)
      end
    end
  end

  def total
    @frames.sum { |frame| frame.calculate_score(@frames) }
  end
end
