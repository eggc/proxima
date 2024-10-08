class ProjectsController < ApplicationController
  after_action :verify_pundit_authorization

  def index
    @projects = policy_scope(Project).order(:visibility, :display_order)
    @projects.where!(visibility: params[:visibility]) if params[:visibility].present?
  end

  def show
    @project = Project.find(params[:id])
    authorize(@project)
  end

  def new
    max_order = Project.where(user: current_user).maximum(:display_order) || 0
    @project = Project.new(user: current_user, display_order: max_order + 1)
    @selectable_pages = build_selectable_pages
    authorize(@project)
  end

  def edit
    @project = Project.find(params[:id])
    @selectable_pages = build_selectable_pages
    @selected_page_ids = @project.pages.ids
    authorize(@project)
  end

  def create
    @project = Project.new(user: current_user)
    authorize(@project)
    @project.update!(project_params)
    redirect_to(projects_path)
  end

  def update
    @project = Project.find(params[:id])
    authorize(@project)
    @project.update!(project_params)
    redirect_to(projects_path)
  end

  def destroy
    @project = Project.find(params[:id])
    authorize(@project)
    @project.destroy!
    redirect_to(projects_path)
  end

  private

  def project_params
    params.require(:project).permit(:theme, :title, :media, :description, :display_order)
  end

  def build_selectable_pages
    Page.where(user: current_user)
      .order(:display_order)
      .map { |page| [page.category_icon + page.content.truncate(30), page.id] }
  end
end
