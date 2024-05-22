# frozen_string_literal: true

require_relative 'frame'

# スコアのトータルを計算する
class Game
  def initialize(shots)
    @shots = shots
  end

  def score
    total_score = 0
    build_frames_from_shots.each.with_index do |frame_shot, i|
      total_score += calculate_frame_scores(frame_shot, i)
    end
    puts total_score
  end

  private

  def build_frames_from_shots
    frames = []
    i = 0
    i = add_shot_to_frames(frames, @shots, i) while i < @shots.size
    frames
  end

  def add_shot_to_frames(frames, shots, index)
    if shots[index] == Shot::STRIKE_MARK
      frames << Frame.new(shots[index])
      index + 1
    else
      frames << Frame.new(shots[index], shots[index + 1])
      index + 2
    end
  end

  def calculate_frame_scores(frame, index)
    if index < 9
      calculate_frame_points(frame, index)
    else
      frame.score
    end
  end

  def calculate_frame_points(frame, index)
    if frame.strike?
      frame.score + calculate_strike_points(index)
    elsif frame.spare?
      frame.score + calculate_spare_points(index)
    else
      frame.score
    end
  end

  def calculate_strike_points(index)
    next_frame = build_frames_from_shots[index + 1]
    next_next_frame = build_frames_from_shots[index + 2]
    connected_frame_scores = next_frame.shots + (next_next_frame ? next_next_frame.shots : [])
    connected_frame_scores.slice(0, 2).sum(&:score)
  end

  def calculate_spare_points(index)
    build_frames_from_shots[index + 1].shots.first.score
  end
end

shots = ARGV[0].split(',')
game = Game.new(shots)
game.score
