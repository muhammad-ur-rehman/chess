# frozen_string_literal: true

require 'test_helper'

class PawnTest < ActiveSupport::TestCase
  test 'should be valid with valid attributes' do
    pawn = Pawn.new(x: 1, y: 2, face: 'NORTH', color: 'WHITE')
    assert pawn.valid?
  end

  test 'should be valid with nil attributes' do
    pawn = Pawn.new
    assert pawn.valid?
  end

  test 'should be invalid with invalid x value' do
    pawn = Pawn.new(x: 8, y: 2, face: 'NORTH', color: 'WHITE')
    assert_not pawn.valid?
    assert_includes pawn.errors.messages[:x], 'must be less than or equal to 7'
  end

  test 'should be invalid with invalid y value' do
    pawn = Pawn.new(x: 1, y: -1, face: 'NORTH', color: 'WHITE')
    assert_not pawn.valid?
    assert_includes pawn.errors.messages[:y], 'must be greater than or equal to 0'
  end

  test 'should be invalid with invalid face value' do
    pawn = Pawn.new(x: 1, y: 2, face: 'SOME_DIRECTION', color: 'WHITE')
    assert_not pawn.valid?
    assert_includes pawn.errors.messages[:face], 'is not included in the list'
  end

  test 'should be invalid with invalid color value' do
    pawn = Pawn.new(x: 1, y: 2, face: 'NORTH', color: 'SOME_COLOR')
    assert_not pawn.valid?
    assert_includes pawn.errors.messages[:color], 'is not included in the list'
  end
end
