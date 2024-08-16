class HouseworkLogsController < ApplicationController
  def create
    @dot_task = HouseworkLog.new(housework_log_params)
    @dot_task.save!
    redirect_to(houseworks_path, status: :see_other)
  end

  private

  def housework_log_params
    params.require(:housework_log).permit(:worked_at, :housework_id)
  end
end
