# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_accessor :next_frame

  def initialize(first_mark, second_mark = nil, third_mark = nil, last: false)
    @shots = []
    @shots[0] = Shot.new(first_mark)
    @shots[1] = Shot.new(second_mark)
    @shots[2] = Shot.new(third_mark)
    @last = last
  end

  def calculate_score
    return score if last?

    if strike?
      10 + strike_bonus
    elsif spare?
      10 + spare_bonus
    else
      two_shot_score
    end
  end

  protected

  def last?
    @last
  end

  def score
    @shots.sum(&:score)
  end

  def first_shot_score
    @shots[0].score
  end

  def two_shot_score
    @shots.first(2).sum(&:score) 
  end

  def strike_bonus
    next_frame.provide_bonus_score
  end
  
  def provide_bonus_score
    if strike? && next_frame
      10 + next_frame.first_shot_score
    else
      two_shot_score
    end
  end

  def spare_bonus
    next_frame.first_shot_score
  end

  def strike?
    @shots[0].strike?
  end

  def spare?
    two_shot_score == 10
  end
end
