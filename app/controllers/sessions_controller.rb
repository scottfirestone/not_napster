class SessionsController < ApplicationController
  def destroy
    log_out
    redirect_to root_path
  end
end
