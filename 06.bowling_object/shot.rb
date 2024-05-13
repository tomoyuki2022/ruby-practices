# frozen_string_literal: true

# マークの"X"の場合10を返し、その他は整数で返す
class Shot
  def initialize(mark)
    @mark = mark
  end

  def score
    return 10 if @mark == 'X'

    @mark.to_i
  end
end
