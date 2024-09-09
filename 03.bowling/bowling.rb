#! /usr/bin/env ruby

# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = []
scores.each do |s|
  shots << (s == 'X' ? 10 : s.to_i)
end

shot_count = 0
point = 0

10.times do
  current_shot = shots[shot_count]
  shot_next_one = shots[shot_count + 1]
  shot_next_tow = shots[shot_count + 2]

  if current_shot == 10
    point += 10 + shot_next_one + shot_next_tow
    shot_count += 1
  elsif current_shot + shot_next_one == 10
    point += 10 + shot_next_tow
    shot_count += 2
  else
    point += current_shot + shot_next_one
    shot_count += 2
  end
end

puts point
