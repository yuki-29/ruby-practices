# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  def initialize(scores)
    scores = scores.split(',')
    @frames = Array.new(10) do |i|
      shot = Shot.new(scores.first)
      if i == 9
        Frame.new(*scores, last: true)
      elsif shot.strike?
        Frame.new(*scores.shift, frame_count: i)
      else
        Frame.new(*scores.shift(2), frame_count: i)
      end
    end
  end

  def total
    @frames.sum { |frame| frame.calculate_score(@frames) }
  end
end
