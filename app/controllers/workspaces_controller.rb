class WorkspacesController < ApplicationController
  after_action :verify_pundit_authorization

  def new
    max_order = Workspace.where(user: current_user).maximum(:display_order) || 0
    @workspace = Workspace.new(user: current_user, display_order: max_order + 1)
    authorize(@workspace)
  end

  def edit
    @workspace = Workspace.find(params[:id])
    authorize(@workspace)
  end

  def create
    @workspace = Workspace.new(user: current_user)
    authorize(@workspace)
    @workspace.update!(workspace_params)
    redirect_to(root_path)
  end

  def update
    @workspace = Workspace.find(params[:id])
    authorize(@workspace)
    @workspace.update!(workspace_params)
    redirect_to(root_path)
  end

  def destroy
    @workspace = Workspace.find(params[:id])
    authorize(@workspace)
    @workspace.destroy!
    redirect_to(root_path)
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :display_order)
  end
end
