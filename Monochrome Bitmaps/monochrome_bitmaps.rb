class Bitmap
  def initialize(bytes, bytes_per_line = bytes.size)
    @bytes = bytes
    @bytes_per_line = bytes_per_line
  end

  def to_s
    if @bytes_per_line == @bytes.size
      @bytes.map { |byte| byte.to_s(2).rjust(8, '0').tr('01', '.#') }.join
    else
      string = ''
      @bytes.each_slice(@bytes_per_line) do |slice|
        string << slice.map do |byte|
          byte.to_s(2).rjust(8, '0').tr('01', '.#')
        end.join
        string << "\n"
      end
      string.strip
    end
  end
end