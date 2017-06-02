class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :require_login
  
private
  def require_login
    flash.keep
    redirect_to login_path unless logged_in?
  end
  
  def require_admin
    flash.keep
    redirect_to root_path unless current_user.admin?
  end
end
