def partition(number)
  (0..number/2).map { |addend| [addend, number - addend] }
end
