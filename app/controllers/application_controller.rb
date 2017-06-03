class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  before_action :require_login
  before_action :set_visible_projects
  
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
  
  def set_visible_projects
    if current_user.admin?
      @visible_projects = Project.all
    else
      @visible_projects = current_user.project_memberships.map { |m| m.project }
    end
  end
end
