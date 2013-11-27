class Object
  def thread(*operations)
    operations.reduce(self) { |result, operation| operation.to_proc.call result }
  end
end