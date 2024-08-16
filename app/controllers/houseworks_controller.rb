class HouseworksController < ApplicationController
  after_action :verify_pundit_authorization

  def index
    @houseworks = policy_scope(Housework).order(display_order: :desc)
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
    @housework = Housework.new(user: current_user)
    authorize(@housework)
    @housework.update!(housework_params)
    redirect_to(houseworks_path)
  end

  def update
    @housework = Housework.find(params[:id])
    authorize(@housework)
    @housework.update!(housework_params)
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
    params.require(:housework).permit(:content, :display_order)
  end
end
