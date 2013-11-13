class Caesar
  def initialize(shift, alphabet = 'abcdefghijklmnopqrstuvwxyz')
    @shift = shift % alphabet.size
    @alphabet = alphabet
  end

  def encrypt(string)
    string.chars.map { |char| @alphabet[@alphabet.index(char) + @shift - @alphabet.size] }.join
  end

  def decrypt(string)
    string.chars.map { |char| @alphabet[@alphabet.index(char) - @shift] }.join
  end
end
