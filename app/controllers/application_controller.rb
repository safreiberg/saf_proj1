class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def current_user
    @_current_user ||= User.find(session[:current_user]) if session[:current_user]
  end
  helper_method :current_user
end
