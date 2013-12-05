class Array
  def to_proc
    proc { |object| map(&object.method(:public_send)) }
  end
end

class Hash
  def to_proc
    proc { |object| each { |method, value| object.public_send "#{method}=", value } }
  end
end
