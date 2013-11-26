def zig_zag(n)
  (1..n * n).each_slice(n).map.with_index do |slice, index|
    index.odd? ? slice.reverse : slice
  end
end
