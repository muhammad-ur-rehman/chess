# frozen_string_literal: true

class InvalidCommandError < StandardError
  attr_reader :message

  def initialize(message = 'Invalid command. Please try again.')
    @message = message
    super(message)
  end
end
