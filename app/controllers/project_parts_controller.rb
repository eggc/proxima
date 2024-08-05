class ProjectPartsController < ApplicationController
  include BuildSelectableProject

  def index
    @project_parts = ProjectPart.order(:display_order).where(user: current_user)
  end

  def show
    @project_part = ProjectPart.where(user: current_user).find(params[:id])
  end

  def new
    max_order = ProjectPart.where(user: current_user).maximum(:display_order)
    @project_part = ProjectPart.new(display_order: max_order + 1)
    @selectable_projects = build_selectable_project
  end

  def edit
    @project_part = ProjectPart.where(user: current_user).find(params[:id])
    @selectable_projects = build_selectable_project
  end

  def create
    @project_part = ProjectPart.new(user: current_user)
    @project_part.update!(project_part_params)
    redirect_to(project_parts_path)
  end

  def update
    @project_part = ProjectPart.where(user: current_user).find(params[:id])
    @project_part.update!(project_part_params)
    redirect_to(project_parts_path)
  end

  def destroy
    @project_part = ProjectPart.where(user: current_user).find(params[:id])
    @project_part.destroy!
    redirect_to(project_parts_path)
  end

  private

  def project_part_params
    params.require(:project_part).permit(:title, :description, :display_order, :project_id)
  end
end
