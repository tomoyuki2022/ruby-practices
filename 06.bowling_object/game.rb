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
      frame = Frame.new(*frame_shot)
      total_score += calculate_frame_scores(frame, i)
    end
    puts total_score
  end

  private

  def build_frames_from_shots
    frames = []
    i = 0
    while i < @shots.size
      i = if @shots[i] == 'X'
            add_strike_shot_to_frames(frames, @shots, i)
          else
            add_shot_to_frames(frames, @shots, i)
          end
    end
    frames
  end

  def add_strike_shot_to_frames(frames, shots, index)
    frames << [shots[index]]
    index + 1
  end

  def add_shot_to_frames(frames, shots, index)
    frames << [shots[index], shots[index + 1]]
    index + 2
  end

  def next_frame(index)
    build_frames_from_shots[index + 1]
  end

  def next_next_frame(index)
    build_frames_from_shots[index + 2] ||= []
  end

  def connect_frame_scores(index)
    connected_frame_scores = next_frame(index) + next_next_frame(index)
    connected_frame_scores.slice(0, 2)
  end

  def score_from_marks(marks)
    marks.map { |m| Shot.new(m).score }
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
    score_from_marks(connect_frame_scores(index)).sum
  end

  def calculate_spare_points(index)
    score_from_marks(next_frame(index)).first
  end
end

shots = ARGV[0].split(',')
game = Game.new(shots)
game.score
