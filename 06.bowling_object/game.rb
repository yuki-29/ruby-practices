# frozen_string_literal: true

require_relative 'frame'
require_relative 'shot'

class Game
  attr_accessor :game

  def initialize(scores)
    scores = scores.split(',')
    @frames = 10.times.map do |i|
          shot = Shot.new(scores.first)
          if i == 9
            Frame.new(*scores, last: true)
          elsif shot.strike?
            Frame.new(*scores.shift)
          else
            Frame.new(*scores.shift(2))
          end
    end
 
    @frames.each_with_index do |frame, i|
      frame.next_frame = @frames[i + 1]
    end
  end

  def total
    @frames.sum(&:calculate_score)
  end
end
