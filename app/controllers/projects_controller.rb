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
    @selectable_ideas = build_selectable_ideas
    authorize(@project)
  end

  def edit
    @project = Project.find(params[:id])
    @selectable_ideas = build_selectable_ideas
    @selected_idea_ids = @project.ideas.ids
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

  def build_selectable_ideas
    Idea.where(user: current_user)
      .order(:display_order)
      .map { |idea| [idea.emote_icon + idea.body.truncate(30), idea.id] }
  end
end
