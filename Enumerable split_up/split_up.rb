module Enumerable
  def split_up(length:, step: length, pad: [], &block)
    sliced = each_slice(step).map { |slice| (slice + pad).take length }
    block ? sliced.each { |slice| yield slice } : sliced
  end
end
