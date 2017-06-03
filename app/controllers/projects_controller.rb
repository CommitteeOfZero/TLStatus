class ProjectsController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :require_read_access, only: :show
  
  # GET /projects
  # GET /projects.json
  def index
    if current_user.admin?
      @projects = Project.all
    else
      @projects = current_user.project_memberships.map { |m| m.project }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @membership = ProjectMembership.new
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :language)
    end
    
    def require_read_access
      redirect_to root_path unless current_user.can_read? @project
    end
end
