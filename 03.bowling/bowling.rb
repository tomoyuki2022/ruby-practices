#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = scores.map { |s| s == 'X' ? 10 : s.to_i }

frame = 0
frame_point = 0
total_point = 0

while frame_point < shots.length && frame < 10
  frame += 1
  if shots[frame_point] == 10
    total_point += 10 + shots[frame_point + 1] + shots[frame_point + 2]
    frame_point += 1
  elsif shots[frame_point] + shots[frame_point + 1] == 10
    total_point += shots[frame_point] + shots[frame_point + 1] + shots[frame_point + 2]
    frame_point += 2
  else
    total_point += shots[frame_point] + shots[frame_point + 1]
    frame_point += 2
  end
end

puts total_point
