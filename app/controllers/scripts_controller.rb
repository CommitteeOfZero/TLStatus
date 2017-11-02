class ScriptsController < ApplicationController
  before_action :set_script
  before_action :load_audits, only: [:edit, :version]
  before_action :get_permissions
  # edit shows script as read-only without write access
  before_action :require_read_access
  before_action :require_write_access, only: :update
  
  def edit
    set_audit_comment
  end

  def version
    @audit = @script.audits[params[:version].to_i - 1]
    set_audit_comment
    @script = @audit.revision
    @can_write = false
    render :edit
  end

  def compare
    @first = @script.audits[params[:first].to_i - 1]
    @second = @script.audits[params[:second].to_i - 1]
    @diff = Diffy::SplitDiff.new(@first.revision.text,
                                 @second.revision.text,
                                 format: :html,
                                 context: 5,
                                 include_plus_and_minus_in_html: true,
                                 include_diff_info: true)
  end

  def update
    set_audit_comment
    # TODO: use validations
    # TODO: support validation errors (update returns false) *and* outside exceptions
    begin
      @script.update(script_params)
      redirect_to edit_script_path(@script), notice: 'Script was successfully updated.'
    rescue => e
      flash[:danger] = "There was an error saving your changes. If this persists please save your work locally and contact an administrator."
      logger.error e
      render :edit
    end
  end
  
private
  def set_script
    @script = Script.find(params[:id])
  end
  
  def load_audits
    @script.audits.load
  end
  
  def script_params
    params.require(:script).permit(:text, :stage, :audit_comment)
  end
  
  def set_audit_comment
    if @audit.present?
      @audit_comment = @audit.comment
    elsif params[:script].present?
      @audit_comment = params[:script][:audit_comment]
    end
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
