class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_admin?
  before_action :set_cart
  attr_writer :current_user

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def log_out
    session.destroy
  end

  def current_admin?
    current_user && current_user.admin?
  end
end
