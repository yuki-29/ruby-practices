# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(shots, frame_count: nil, last: false)
    @shots = shots
    @frame_count = frame_count
    @last = last
  end

  def calculate_score(frames)
    return score if last?

    next_frame = frames[@frame_count + 1]
    second_next_frame = frames[@frame_count + 2]
    if strike?
      10 + strike_bonus(next_frame, second_next_frame)
    elsif spare?
      10 + spare_bonus(next_frame)
    else
      two_shot_score
    end
  end

  protected

  def provide_bonus_score(second_next_frame)
    if strike? && second_next_frame
      10 + second_next_frame.first_shot_score
    else
      two_shot_score
    end
  end

  def first_shot_score
    @shots[0].score
  end

  private

  def score
    @shots.sum(&:score)
  end

  def two_shot_score
    @shots.first(2).sum(&:score)
  end

  def last?
    @last
  end

  def strike_bonus(next_frame, second_next_frame)
    next_frame.provide_bonus_score(second_next_frame)
  end

  def spare_bonus(next_frame)
    next_frame.first_shot_score
  end

  def strike?
    @shots[0].strike?
  end

  def spare?
    !strike? && two_shot_score == 10
  end
end
