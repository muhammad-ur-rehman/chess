# frozen_string_literal: true

require 'test_helper'

class ChessServiceTest < ActiveSupport::TestCase
  setup do
    @pawn = Pawn.first
    @session = {}
    @chess_service = ChessService.new(@pawn, @session)
  end

  test 'place method updates the position and direction' do
    assert_not_nil @pawn.x
    assert_not_nil @pawn.y
    assert_not_nil @pawn.face
    assert_not_nil @pawn.color

    new_x, new_y = 2, 3
    new_facing = 'NORTH'
    new_color = 'WHITE'

    @chess_service.place(new_x, new_y, new_facing, new_color)

    assert_equal new_x, @chess_service.instance_variable_get(:@x)
    assert_equal new_y, @chess_service.instance_variable_get(:@y)
    assert_equal new_facing, @chess_service.instance_variable_get(:@facing)
    assert_equal new_color, @chess_service.instance_variable_get(:@color)
  end

  test 'move method updates the position' do
    assert_not_nil @pawn.x
    assert_not_nil @pawn.y

    initial_x, initial_y = @pawn.x, @pawn.y
    results = @chess_service.move

    assert_not_equal initial_x, results[:x]
  end

  test 'left method updates the direction' do
    assert_not_nil @pawn.face

    initial_facing = @pawn.face
    @chess_service.left

    assert_not_equal initial_facing, @chess_service.instance_variable_get(:@facing)
  end

  test 'right method updates the direction' do
    assert_not_nil @pawn.face

    initial_facing = @pawn.face
    @chess_service.right

    assert_not_equal initial_facing, @chess_service.instance_variable_get(:@facing)
  end
end
