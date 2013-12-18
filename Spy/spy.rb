class Spy < BasicObject
  attr_reader :calls

  def initialize(target)
    @target = target
    @calls = []
  end

  private

  def method_missing(meth, *args, &block)
    if @target.respond_to? meth
      @calls << meth
      @target.public_send(meth, *args, &block)
    else
      ::Kernel.raise Error
    end
  end

  class Error < ::NoMethodError
  end
end
