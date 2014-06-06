module SumSquareDifference
  def self.sum_difference(n)
    (self.sum_of_numbers(n) ** 2) - self.sum_of_squares(n)
  end

  def self.sum_of_numbers(n)
    1.upto(n).reduce(:+)
  end

  def self.sum_of_squares(n)
    1.upto(n).reduce { |sum, addend| sum + addend ** 2 }
  end
end