class HouseworkLogsController < ApplicationController
  def create
    @housework_log = HouseworkLog.new(housework_log_params)
    @housework_log.save!
    redirect_to(houseworks_path, status: :see_other)
  end

  def destroy
    @housework_log = HouseworkLog.find(params[:id])
    @housework_log.destroy!
    redirect_back_or_to(houseworks_path, status: :see_other)
  end

  private

  def housework_log_params
    params.require(:housework_log).permit(:worked_at, :housework_id)
  end
end
