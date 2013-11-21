class Polynomial
  def initialize(*coefficients)
    @coefficients = coefficients.reverse
  end

  def evaluate(x)
    @coefficients.map.with_index { |k, index| k * (x**index) }.reduce(0, :+)
  end

  def to_s
    @coefficients.map.with_index do |k, index|
      case index
      when 0
        if @coefficients.size == 1
          "#{k}"
        else
          k > 0 ? "+#{k}" : "#{k}"
        end
      when 1
        @coefficients.size == 2 ? "#{k}x" : "#{k}x"
      when 2...@coefficients.size
        k > 0 ? "#{k}x^#{index}" : "#{k}x^#{index}"
      else
        k > 0 ? "+#{k}x^#{index}" : "#{k}x^#{index}"
      end
    end.reverse.join
  end
end

polynomial = Polynomial.new([3, -2, -1, 5])
one = Polynomial.new [1]
puts one
# puts polynomial.evaluate(3) #=> 65
# puts polynomial.evaluate(0)
puts polynomial.to_s

zero = Polynomial.new 0
zero.evaluate(5)