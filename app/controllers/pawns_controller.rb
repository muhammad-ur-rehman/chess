# frozen_string_literal: true

class PawnsController < ApplicationController
  include ChessActions
  attr_accessor :chess_service

  def chess_board
    @pawn = Pawn.find_or_create_by(id: game_id)
  end

  def process_command
    @chess_service = ChessService.new(@pawn, session)
    result = perform_action

    if result == 'REPORT'
      flash.now[:notice] = get_report(@pawn)
    else
      flash.now[:notice] = 'Pawn was successfully Moved.'
      @pawn.update(result)
    end

    respond_to do |format|
      format.html { render 'pawns/chess_board', status: :found }
      format.turbo_stream
    end
  end

  private

    def permitted_params
      params.permit('command')
    end
end
