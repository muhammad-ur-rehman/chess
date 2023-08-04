# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pawns#chess_board'

  scope :chess do
    get 'board', to: 'pawns#chess_board'
    patch 'board/:id/process-command', to: 'pawns#process_command', as: :process_command
  end
end
