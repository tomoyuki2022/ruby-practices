# frozen_string_literal: true

# マークの"X"の場合10を返し、その他は整数で返す
class Shot
  STRIKE_MARK = 'X'

  def initialize(mark)
    @mark = mark
  end

  def score
    @mark == STRIKE_MARK ? 10 : @mark.to_i
  end
end
