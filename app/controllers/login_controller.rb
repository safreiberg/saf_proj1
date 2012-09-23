class LoginController < ApplicationController

  def create
    if user = User.authenticate(params[:username], params[:password])
      session[:current_user] = user.name
      redirect_to root_url
    end
  end

  def destroy
    @_current_user = session[:current_user] = nil
    redirect_to root_url
  end

end
