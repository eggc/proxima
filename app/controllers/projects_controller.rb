class ProjectsController < ApplicationController
  after_action :verify_pundit_authorization

  def index
    @projects = policy_scope(Project).order(:visibility, :display_order)
    @projects.where!(visibility: params[:visibility]) if params[:visibility].present?
  end

  def show
    cookies[:current_workspace_id] = params[:id]
    @project = Project.find(params[:id])
    authorize(@project)
  end

  def new
    max_order = Project.where(user: current_user).maximum(:display_order) || 0
    @project = Project.new(user: current_user, display_order: max_order + 1)
    @selectable_dots = build_selectable_dots
    authorize(@project)
  end

  def edit
    @project = Project.find(params[:id])
    @selectable_dots = build_selectable_dots
    @selected_dot_ids = @project.dots.ids
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

  def build_selectable_dots
    Dot.where(user: current_user)
      .order(:display_order)
      .map { |dot| [dot.emote_icon + dot.content.truncate(30), dot.id] }
  end
end
