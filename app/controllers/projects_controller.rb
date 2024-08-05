class ProjectsController < ApplicationController
  def index
    @projects = Project.order(:display_order).where(user: current_user)
  end

  def show
    @project = Project.where(user: current_user).find(params[:id])
  end

  def new
    max_order = Project.where(user: current_user).maximum(:display_order)
    @project = Project.new(display_order: max_order + 1)
  end

  def edit
    @project = Project.where(user: current_user).find(params[:id])
  end

  def create
    @project = Project.new(user: current_user)
    @project.update!(project_params)
    redirect_to(projects_path)
  end

  def update
    @project = Project.where(user: current_user).find(params[:id])
    @project.update!(project_params)
    redirect_to(projects_path)
  end

  def destroy
    @project = Project.where(user: current_user).find(params[:id])
    @project.destroy!
    redirect_to(projects_path)
  end

  private

  def project_params
    params.require(:project).permit(:title, :media, :description, :display_order)
  end
end
