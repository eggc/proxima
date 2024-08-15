class DotTasksController < ApplicationController
  def create
    @dot_task = DotTask.new(dot_id: params[:dot_id])
    @dot_task.save!
    redirect_to(dots_path(anchor: params[:dot_id]), status: :see_other)
  end
end
