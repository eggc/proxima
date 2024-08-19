class HouseworksController < ApplicationController
  after_action :verify_pundit_authorization

  def index
    @houseworks = policy_scope(Housework).order(:display_order)
  end

  def new
    max_order = Housework.where(user: current_user).maximum(:display_order) || 0
    @housework = Housework.new(user: current_user, display_order: max_order + 1)
    authorize(@housework)
  end

  def edit
    @housework = Housework.find(params[:id])
    authorize(@housework)
  end

  def create
    raise HouseworkLimitExceeded if Housework.where(user: current_user).count > 100

    @housework = Housework.new(user: current_user)
    authorize(@housework)
    @housework.update!(housework_params)

    redirect_to(houseworks_path)
  end

  def update
    @housework = Housework.find(params[:id])
    authorize(@housework)

    ApplicationRecord.transaction do
      @housework.update!(housework_params)
      @housework.update_housework_logs!(housework_logs_params)
      @housework.save_last_worked_at!
    end

    redirect_to(houseworks_path)
  end

  def destroy
    @housework = Housework.find(params[:id])
    authorize(@housework)
    @housework.destroy!
    redirect_to(houseworks_path)
  end

  private

  def housework_params
    permitted_params.slice(:content, :display_order)
  end

  def housework_logs_params
    permitted_params[:housework_logs]&.values || []
  end

  def permitted_params
    params.require(:housework).permit(:content, :display_order, housework_logs: %i[id housework_id worked_at memo])
  end
end
