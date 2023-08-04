# frozen_string_literal: true

class Pawn < ApplicationRecord
  validates :x, :y, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 7 },
                    allow_nil: true
  validates :face, inclusion: { in: %w(EAST WEST NORTH SOUTH), allow_nil: true }
  validates :color, inclusion: { in: %w(WHITE BLACK), allow_nil: true }
end
