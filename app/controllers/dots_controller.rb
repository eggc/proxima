class DotsController < ApplicationController
  after_action :verify_pundit_authorization

  def index
    @dots = policy_scope(Dot).where(workspace: current_workspace).order(display_order: :desc)
    @dots.where!(category: params[:category]) if params[:category].present?
  end

  def edit
    @dot = Dot.find(params[:id])
    authorize(@dot)
  end

  def create
    @dot = build_new_dot(current_user, current_workspace, params[:category])
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
    params.require(:dot).permit(:content, :category, :display_order)
  end

  def build_new_dot(user, workspace, category)
    max_order = Dot.where(user:).maximum(:display_order) || 0
    @dot = Dot.new(user:, display_order: max_order + 1, workspace:)
    @dot.category = category if category.present?
    @dot
  end
end
