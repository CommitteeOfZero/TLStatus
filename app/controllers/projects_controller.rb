class ProjectsController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_project, only: [:show, :edit, :update, :destroy, :download, :style_guide, :update_style_guide]
  before_action :require_read_access, only: [:show, :download]
  before_action :require_write_access, only: [:update_style_guide]
  
  # GET /projects
  # GET /projects.json
  def index
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @scripts = @project.scripts.with_note_count
    @membership = ProjectMembership.new
    @changes = @project.associated_audits.where(auditable_type: "Script", action: :update)
                                         .order(created_at: :desc)
                                         .paginate(page: params[:page],
                                                   per_page: 10)
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
  
  def download
    time = Time.zone.now
    buf = Zip::OutputStream.write_buffer do |zio|
      zio.comment = "Generated #{time}"
      @project.scripts.each do |script|
        zio.put_next_entry script.name
        zio.write script.text
      end
    end
    buf.rewind
    send_data buf.read, filename: "#{@project.name}_#{time.to_i}.zip"
  end
  
  def style_guide
  end
  
  def update_style_guide
    if @project.update(style_guide_params)
      redirect_to style_guide_path(@project), notice: 'Style guide was successfully updated.'
    else
      render :style_guide
    end
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
    
    def style_guide_params
      params.require(:project).permit(:style_guide)
    end
    
    def require_read_access
      redirect_to root_path unless current_user.can_read? @project
    end
    
    def require_write_access
      redirect_to root_path unless current_user.can_write? @project
    end
end
