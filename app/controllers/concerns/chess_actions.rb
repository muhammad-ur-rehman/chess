# frozen_string_literal: true

module ChessActions
  extend ActiveSupport::Concern
  include SessionHelper

  included do
    before_action :find_pawn, only: [:process_command]
    before_action :set_game_id, only: [:chess_board]
  end

  private

    def find_pawn
      @pawn = Pawn.find(params['id'])
    end

    def perform_action
      command = permitted_params['command']
      parts = command.split
      case parts[0]
        when 'PLACE'
          x, y, facing, color = parts[1].split(',')
          chess_service.place(x.to_i, y.to_i, facing, color)
        when 'MOVE'
          if parts.length > 1
            steps = parts[1]
            chess_service.move(steps.to_i)
          else
            chess_service.move
          end
        when 'LEFT'
          chess_service.left
        when 'RIGHT'
          chess_service.right
        when 'REPORT'
          'REPORT'
        else
          raise InvalidCommandError
      end
    end

    def get_report(pawn)
      "Pawn is on x: #{pawn.x}, y: #{pawn.y}, color: #{pawn.color}, facing: #{pawn.face}"
    end
end
