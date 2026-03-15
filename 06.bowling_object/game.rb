# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  def initialize(scores)
    shots = scores.split(',').map { |score| Shot.new(score) }

    @frames = Array.new(10) do |i|
      if i == 9
        Frame.new(shots, last: true)
      elsif shots.first.strike?
        Frame.new([shots.shift], frame_count: i)
      else
        Frame.new(shots.shift(2), frame_count: i)
      end
    end
  end

  def total
    @frames.sum { |frame| frame.calculate_score(@frames) }
  end
end
