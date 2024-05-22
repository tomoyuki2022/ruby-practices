# frozen_string_literal: true

require_relative 'shot'

# 各フレームの合計を出す
class Frame
  STRIKE = 10
  attr_accessor :shots

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @shots = [first_mark, second_mark, third_mark].compact.map { |mark| Shot.new(mark) }
  end

  def score
    @shots.sum(&:score)
  end

  def strike?
    @shots.first.score == STRIKE
  end

  def spare?
    if @shots.first.score != STRIKE
      @shots.slice(0, 2).sum(&:score) == 10
    else
      false
    end
  end
end
