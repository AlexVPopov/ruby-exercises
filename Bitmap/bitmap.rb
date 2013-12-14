class Bitmap
  def initialize(bytes, bytes_per_row = bytes.size)
    @bytes = bytes
    @bytes_per_row = bytes_per_row
  end

  def render(colors = ['.', '#'])
    pixel_size = Math.log(colors.size, 2)
    binary = @bytes.flat_map { |byte| ("%08b" % byte).chars }
    colorized = binary.each_slice(pixel_size).map { |s| colors[s.join.to_i 2] }
    colorized.each_slice(@bytes_per_row * (8 / pixel_size)).map(&:join).join("\n")
  end
end
