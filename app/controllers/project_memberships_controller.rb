class ProjectMembershipsController < ApplicationController
  before_action :require_admin
  before_action :set_project_membership, only: [:destroy]
  
  def create
    @project_membership = ProjectMembership.new(membership_params)
    if @project_membership.save
      redirect_to request.referer
    else
      flash[:danger] = "Could not save project membership"
      redirect_to request.referer
    end
  end

  def destroy
    @project_membership.destroy
    redirect_to request.referer, notice: "Member was successfully removed."
  end
  
private
  def membership_params
    params.require(:project_membership).permit(:user_id, :project_id, :position, :write_access)
  end
  
  def set_project_membership
    @project_membership = ProjectMembership.find(params[:id])
  end
end
