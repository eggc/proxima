class DotTasksController < ApplicationController
  def update
    @dot_task = DotTask.find(params[:id])
    @dot_task.toggle!
    redirect_to(tree_path)
  end
end
