class AndSpec < AbstractSpec
  attr_reader :left, :right

  def initialize(left, right)
    @left = left
    @right = right
  end

  def satisfies?(candidate)
    @left.satisfies?(candidate) && @right.satisfies?(candidate)
  end
end
