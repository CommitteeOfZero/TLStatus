class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :auth_failure]
  
  def new
    redirect_to root_path and return if logged_in?
    render layout: false
  end
  
  def create
    redirect_to root_path and return unless params[:provider] == "discord" && !logged_in?
    
    user = User.find_by(discord_uid: request.env["omniauth.auth"]["uid"])
    if user.nil?
      flash[:notice] = "No user associated with this Discord account."
      redirect_to root_path and return
    end
    
    login(user)
    redirect_to root_path # TODO redirect back
  end

  def destroy
    logout
    redirect_to root_path
  end
  
  def auth_failure
    flash[:notice] = "Access denied"
    redirect_to root_path
  end
end
