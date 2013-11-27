class String
  def longest_sequence
    longest = {}
    current = 1
    chars.each_with_index do |char, i|
      if chars[i] == chars[i+1]
        current += 1
      else
        longest[char] = current if not longest[char] or longest[char] < current
        current = 1
      end
    end
    longest.select { |k, v| v == longest.values.max }.keys
  end
end