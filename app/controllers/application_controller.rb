class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :require_login
  
private
  def require_login
    unless logged_in?
      flash.keep
      redirect_to login_path
    end
  end
  
  def require_admin
    unless current_user.admin?
      flash.keep
      redirect_to root_path
    end
  end
end
