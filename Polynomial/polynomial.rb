class Polynomial
  def initialize(coefficients)
    @coefficients = coefficients.reverse
  end

  def to_s
    return '0' if @coefficients.all?(&:zero?)
    @coefficients.map.with_index do |k, index|
      " #{"++-"[k <=> 0]} #{k.abs}x^#{index}"
    end.reverse.join
    .strip                        # removes whitespace at the front
    .gsub(/\A\+\s/, '')           # removes + if first coefficient is positive
    .gsub(/\A0x\^\d*\s/, '')      # removes fist member if coefficient is 0
    .gsub(/x\^0/, '')             # removes x to the power of 0
    .gsub(/\s(\+|-)\s0x\^\d/, '') # removes 0 coefficients
    .gsub(/\s(\+|-)\s0/, '')      # removes 0 at the end of the expression
    .gsub(/\^1(?!\d)/, '')        # removes power of 1
    .gsub(/(?<!\d)1x/, 'x')       # removes 1 coefficients
  end

  def evaluate(x)
    @coefficients.reverse.inject(0){ | res, coef | res * x + coef }
  end
end
