class ProjectMembershipsController < ApplicationController
  before_action :require_admin
  
  def create
    @project_membership = ProjectMembership.new(membership_params)
    if @project_membership.save
      redirect_to request.referer
    else
      flash[:danger] = "Could not save project membership"
      redirect_to request.referer
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
private
  def membership_params
    params.require(:project_membership).permit(:user_id, :project_id, :position, :write_access)
  end
end
