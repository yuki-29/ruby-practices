# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_accessor :game

  def initialize(scores)
    scores = scores.split(',')
    @frames = []
    10.times do |i|
      @frames << if i == 9
                 Frame.new(*scores, last: true)
               elsif scores.first == 'X'
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
    @frames.sum(&:frame_score_calc)
  end
end
