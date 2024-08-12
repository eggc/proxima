class CurrentWorkspacesController < ApplicationController
  def update
    cookies[:current_workspace_id] = params[:id]

    redirect_back_or_to(root_path)
  end
end
