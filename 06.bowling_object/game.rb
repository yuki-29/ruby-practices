# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_accessor :game

  def initialize(scores)
    scores = scores.split(',')
    @game = []
    10.times do |i|
      @game << if i == 9
                 Frame.new(*scores, last: true)
               elsif scores.first == 'X'
                 Frame.new(*scores.shift)
               else
                 Frame.new(*scores.shift(2))
               end
    end

    @game.each_with_index do |frame, i|
      frame.next_frame = @game[i + 1]
    end
  end

  def total
    @game.sum(&:frame_score_calc)
  end
end
