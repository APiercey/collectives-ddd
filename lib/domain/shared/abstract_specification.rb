class AbstractSpec
  def initialize(*args)
    super(*args)
  end

  def satisfies?(*args)
    raise "Must implement satisfies"
  end

  def and(other)
    AndSpec.new(self, other)
  end

  def not(other)
    NotSpec.new(self, other)
  end

  def or(other)
    OrSpec.new(self, other)
  end
end
