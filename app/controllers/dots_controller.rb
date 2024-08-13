class DotsController < ApplicationController
  after_action :verify_pundit_authorization

  def index
    @dots = policy_scope(Dot).where(workspace: current_workspace).order(:display_order)
    @dots.where!(emote: params[:emote]) if params[:emote].present?
  end

  def edit
    @dot = Dot.find(params[:id])
    authorize(@dot)
  end

  def create
    max_order = Dot.where(user: current_user).maximum(:display_order) || 0
    @dot = Dot.new(user: current_user, display_order: max_order + 1, workspace: current_workspace)
    authorize(@dot)
    @dot.save!
    redirect_back_or_to(dots_path)
  end

  def update
    @dot = Dot.find(params[:id])
    authorize(@dot)
    @dot.update!(dot_params)
    redirect_to(dots_path)
  end

  def destroy
    @dot = Dot.find(params[:id])
    authorize(@dot)
    @dot.destroy!
    redirect_to(dots_path)
  end

  private

  def dot_params
    params.require(:dot).permit(:content, :emote, :display_order)
  end
end
