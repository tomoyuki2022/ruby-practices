# frozen_string_literal: true

require_relative 'shot'

# 各フレームの合計を出す
class Frame
  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    [@first_shot.score, @second_shot.score, @third_shot.score].sum
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    @first_shot.score + @second_shot.score == 10
  end
end
