# frozen_string_literal: true

class ChessService
  include SessionHelper

  attr_accessor :session

  DIMENSIONS = 8
  DIRECTIONS = {
    'NORTH' => [0, 1],
    'SOUTH' => [-1, 0],
    'EAST' => [1, 0],
    'WEST' => [0, -1]
  }.freeze

  def initialize(pawn, session)
    @x = pawn.x
    @y = pawn.y
    @facing = pawn.face
    @color = pawn.color
    @session = session
  end

  def place(x, y, facing, color)
    return unless valid_coordinates?(x, y) && DIRECTIONS.key?(facing)

    @x = x
    @y = y
    @facing = facing
    @color = color
    set_first_move(true)
    updated_state
  end

  def move(steps = 1)
    raise_invalid_command_error unless placed?

    steps = first_move? ? [2, steps].min : 1

    steps.times do
      new_x, new_y = next_position
      break unless valid_coordinates?(new_x, new_y)

      @x = new_x
      @y = new_y
    end

    set_first_move(false)
    updated_state
  end

  def left
    raise_invalid_command_error unless placed?

    @facing = turn_left(@facing)
    updated_state
  end

  def right
    raise_invalid_command_error unless placed?

    @facing = turn_right(@facing)
    updated_state
  end

  private

    def placed?
      !@x.nil? && !@y.nil? && !@facing.nil? && !@color.nil?
    end

    def valid_coordinates?(x, y)
      x.between?(0, DIMENSIONS - 1) && y.between?(0, DIMENSIONS - 1)
    end

    def next_position
      dx, dy = DIRECTIONS[@facing]
      [(@x + dx), (@y + dy)]
    end

    def turn_left(current_facing)
      DIRECTIONS.keys.rotate(-1)[DIRECTIONS.keys.index(current_facing)]
    end

    def turn_right(current_facing)
      DIRECTIONS.keys.rotate[DIRECTIONS.keys.index(current_facing)]
    end

    def updated_state
      { x: @x, y: @y, face: @facing, color: @color }
    end

    def raise_invalid_command_error(message = 'Cannot process, this command before PLACE command')
      raise InvalidCommandError, message
    end
end
