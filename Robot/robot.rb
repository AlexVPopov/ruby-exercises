class Robot
  def initialize(start)
    @current_position = start
    @marked_positions = []
  end

  def mark
    @marked_positions << @current_position
  end

  def move
    @current_position += 1
  end
end

def robot(start = 0, &commands)
  Robot.new(start).instance_eval(&commands) or []
end
