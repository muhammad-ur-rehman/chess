class ApplicationController < ActionController::Base
  rescue_from InvalidCommandError, with: :handle_invalid_command

  private

    def handle_invalid_command(exception)
      flash[:error] = exception.message
      redirect_to(root_path)
    end
end
