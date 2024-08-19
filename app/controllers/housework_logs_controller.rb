class HouseworkLogsController < ApplicationController
  def create
    @housework_log = HouseworkLog.new(housework_log_params)

    ApplicationRecord.transaction do
      @housework_log.save!
      @housework_log.housework.save_last_worked_at!
    end

    redirect_to(houseworks_path, status: :see_other)
  end

  def destroy
    @housework_log = HouseworkLog.find(params[:id])

    ApplicationRecord.transaction do
      @housework_log.destroy!
      @housework_log.housework.save_last_worked_at!
    end

    redirect_back_or_to(houseworks_path, status: :see_other)
  end

  private

  def housework_log_params
    params.require(:housework_log).permit(:worked_at, :housework_id)
  end
end
