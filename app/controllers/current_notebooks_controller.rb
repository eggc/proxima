class CurrentNotebooksController < ApplicationController
  def update
    cookies[:current_notebook_id] = params[:id]

    redirect_back_or_to(root_path)
  end
end
