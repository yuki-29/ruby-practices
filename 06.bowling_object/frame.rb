# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_accessor :last_frame, :next_frame

  def initialize(first_mark, second_mark = nil, third_mark = nil, last: false)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
    @last_frame = last
  end

  def last?
    @last_frame
  end

  def score
    [@first_shot.score,
     @second_shot.score,
     @third_shot.score].sum
  end

  def two_shot_score
    [@first_shot.score,
     @second_shot.score].sum
  end

  def frame_score_calc
    return score if last?

    if strike?
      10 + strike_bonus
    elsif spare?
      10 + spare_bonus
    else
      two_shot_score
    end
  end

  def strike_bonus
    if !next_frame.nil?
      next_frame.provide_bonus_score
    else
      two_shot_score
    end
  end

  def provide_bonus_score
    if next_frame.nil?
      two_shot_score
    elsif strike?
      10 + next_frame.first_shot_score
    else
      two_shot_score
    end
  end

  def spare_bonus
    next_frame.first_shot_score
  end

  def first_shot_score
    @first_shot.score
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    @first_shot.score + @second_shot.score == 10
  end
end
