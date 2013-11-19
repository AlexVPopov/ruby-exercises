class BinaryMobile
  def initialize(b1, b2)
    @b1 = b1
    @b2 = b2
  end

  def weight
    @b1.weight + @b2.weight
  end

  def balanced?
    if @b1.finite? and @b2.finite?
      @b1.momentum == @b2.momentum
    else
      @b1.object_balanced? and
      @b2.object_balanced? and
      @b1.momentum == @b2.momentum
    end
  end
end

class Branch
  attr_reader :object

  def initialize(length, object)
    @length = length
    @object = object
  end

  def finite?
    @object.is_a? Numeric
  end

  def weight
    finite? ? @object : @object.weight
  end

  def object_balanced?
    finite? ? true : @object.balanced?
  end

  def momentum
    @length * weight
  end
end