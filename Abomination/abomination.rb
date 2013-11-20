class Abomination < BasicObject
  def initialize(*objects)
    @objects = objects
  end

  def method_missing(method, *args, &block)
    match = @objects.find { |object| object.respond_to? method }
    ::Kernel.raise ::NoMethodError unless match
    match.public_send(method, *args, &block)
  end

  def is_a?(klass)
    klass == ::Abomination or @objects.map(&:class).include? klass
  end
end
