class DotTasksController < ApplicationController
  def create
    @dot_task = DotTask.new(dot_id: params[:dot_id])
    @dot_task.save!
    redirect_back_or_to(dots_path)
  end
end
