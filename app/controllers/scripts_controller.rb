class ScriptsController < ApplicationController
  before_action :set_script
  before_action :get_permissions
  # edit shows script as read-only without write access
  before_action :require_read_access
  before_action :require_write_access, only: :update
  
  def edit
  end

  def update
    if @script.update(script_params)
      redirect_to edit_script_path(@script), notice: 'Script was successfully updated.'
    else
      render :edit
    end
  end
  
private
  def set_script
    @script = Script.find(params[:id])
  end
  
  def script_params
    params.require(:script).permit(:text, :stage)
  end
  
  def get_permissions
    @can_read = current_user.can_read? @script.project
    @can_write = current_user.can_write? @script.project
  end
  
  def require_read_access
    redirect_to root_path unless @can_read
  end
  
  def require_write_access
    redirect_to root_path unless @can_write
  end
end
