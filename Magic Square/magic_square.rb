def magic_square? square
  unless square.instance_of? Array and
         square.all? { |line| line.instance_of? Array } and
         square.all? { |line| line.all? { |element| element.is_a? Integer } }
    raise ArgumentError
  end
  sum = square[0].reduce(:+)
  left_diagonal_sum, right_diagonal_sum = 0, 0
  square.each_with_index { |line, index| left_diagonal_sum += line[index] }
  square.each_with_index { |line, index| right_diagonal_sum += line.reverse[index] }
  square.all? { |line| line.reduce(:+) == sum } and
  square.transpose.all? { |line| line.reduce(:+) == sum } and
  left_diagonal_sum == sum and
  right_diagonal_sum == sum
end
