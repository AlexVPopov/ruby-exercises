module Graphics
  class Canvas
    attr_reader :width, :height
    attr_accessor :canvas

    def initialize(width, height)
      @width = width
      @height = height
      @canvas = Array.new(height) { Array.new(width) }
    end

    def set_pixel(x, y)
      @canvas[y][x] = true
    end

    def pixel_at?(x, y)
      @canvas[y][x]
    end

    def draw(figure)
      figure.path.each { |coordinate| set_pixel coordinate[0], coordinate[1] }
    end

    def render_as(renderer)
      renderer.render(self)
    end
  end

  module Renderers
    module Ascii
      def self.render(canvas)
        canvas.canvas.map { |row| Renderers.process_row(row, '@', '-') }.join("\n")
      end
    end

    module Html
      HEADER = <<-EOS
<!DOCTYPE html>
<html>
<head>
  <title>Rendered Canvas</title>
  <style type="text/css">
    .canvas {
      font-size: 1px;
      line-height: 1px;
    }
    .canvas * {
      display: inline-block;
      width: 10px;
      height: 10px;
      border-radius: 5px;
    }
    .canvas i {
      background-color: #eee;
    }
    .canvas b {
      background-color: #333;
    }
  </style>
</head>
<body>
  <div class="canvas">
               EOS

      FOOTER = <<-EOS
  </div>
</body>
</html>
               EOS

      def self.render(canvas)
        HEADER +
        canvas.canvas.map { |row| Renderers.process_row(row, '<b></b>', '<i></i>') }
        .join("<br>\n") +
        FOOTER
      end
    end

    private

    def self.fill_pixel(pixel, color, transparent)
      pixel ? color : transparent
    end

    def self.process_row(row, color, transparent)
      row.map { |pixel| Renderers.fill_pixel(pixel, color, transparent) }.join
    end
  end

  class Point
    include Graphics
    attr_reader :x, :y, :path

    def initialize(x, y)
      @x = x
      @y = y
      @path = [[@x, @y]]
    end
  end

  class Line
    include Graphics
    attr_reader :from, :to, :path

    def initialize(from, to)
      @from, @to = from, to
      @delta_x, @delta_y = (@to.x - @from.x).abs, -(@to.y - @from.y).abs
      @step_x, @step_y  = (@from.x < @to.x ? 1 : -1), (@from.y < @to.y ? 1 : -1)
      @err, @x, @y = @delta_x + @delta_y, @from.x, @from.y
      @path = [[@x, @y]]
      set_path
    end

    private

    def set_path
      begin
        @error_2 = 2 * @err
        correct_x
        correct_y
        @path << [@x, @y]
      end until (@x == @to.x && @y == @to.y)
    end

    def correct_x
      if @error_2 >= @delta_y
          @err += @delta_y
          @x += @step_x
      end
    end

    def correct_y
      if @error_2 <= @delta_x
        @err += @delta_x
        @y += @step_y
      end
    end
  end

  class Rectangle
    include Graphics
    attr_reader :left, :right, :top_left, :top_right,
                :bottom_left, :bottom_right, :path

    def initialize(first, second)
      @min_x, @max_x = [first.x, second.x].min, [first.x, second.x].max
      @min_y, @max_y = [first.y, second.y].min, [first.y, second.y].max
      set_corners
      set_path
    end

    private

    def set_corners
      @top_left     = @left  = Point.new @min_x, @min_y
      @top_right             = Point.new @max_x, @min_y
      @bottom_left           = Point.new @min_x, @max_y
      @bottom_right = @right = Point.new @max_x, @max_y
    end

    def set_path
      @path  = Line.new(@top_left, @top_right).path +
               Line.new(@top_right, @bottom_right).path +
               Line.new(@bottom_right, @bottom_left).path +
               Line.new(@top_left, @bottom_left).path
    end
  end

  def eql?(other)
    path == other.path
  end

  alias :== :eql?

  def hash
    @path.hash
  end
end
