class PageTasksController < ApplicationController
  def create
    @page_task = PageTask.new(page_id: params[:page_id])
    @page_task.save!
    redirect_to(pages_path(anchor: params[:page_id]), status: :see_other)
  end
end
