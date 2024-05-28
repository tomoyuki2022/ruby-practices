# frozen_string_literal: true

require_relative 'frame'

# スコアのトータルを計算する
class Game
  def initialize
    @frames = build_frames_from_shots
  end

  def score
    total_score = @frames.each.with_index.sum { |frame_shot, i| calculate_frame_scores(frame_shot, i) }
    puts total_score
  end

  private

  def build_frames_from_shots
    shots = ARGV[0].split(',')
    frames = []
    i = 0
    while i < shots.size
      i, frame = add_shot_to_frames(shots, i)
      frames << frame
    end
    frames
  end

  def add_shot_to_frames(shots, index)
    if shots[index] == Shot::STRIKE_MARK
      frame = Frame.new(shots[index])
      [index + 1, frame]
    else
      frame = Frame.new(shots[index], shots[index + 1])
      [index + 2, frame]
    end
  end

  def calculate_frame_scores(frame, index)
    return frame.score if index >= 9
    return frame.score + calculate_strike_points(index) if frame.strike?
    return frame.score + calculate_spare_points(index) if frame.spare?

    frame.score
  end

  def calculate_strike_points(index)
    next_frame = @frames[index + 1]
    next_next_frame = @frames[index + 2]
    connected_frame_scores = next_frame.shots + (next_next_frame&.shots || [])
    connected_frame_scores.slice(0, 2).sum(&:score)
  end

  def calculate_spare_points(index)
    @frames[index + 1].shots.first.score
  end
end

game = Game.new
game.score
