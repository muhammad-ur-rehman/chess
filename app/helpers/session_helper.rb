# frozen_string_literal: true

module SessionHelper
  private

    def set_first_move(move)
        session[:first_move] = move
    end

    def first_move?
        session[:first_move]
    end

    def set_game_id
        session[:game_id] ||= generate_unique_game_id
    end

    def game_id
      session[:game_id]
    end

    def generate_unique_game_id
      loop do
        game_id = SecureRandom.hex(10)
        break game_id unless Pawn.exists?(id: game_id)
      end
    end
end
