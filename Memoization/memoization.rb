class Memoizer < BasicObject
  def initialize(object)
    @object = object
    @cache  = ::Hash.new { |cache, args| cache[args] = @object.public_send(*args) }
  end

  private

  def method_missing(meth, *args, &block)
    block ? @object.public_send(meth, *args, &block) : @cache[[meth, *args]]
  end
end
