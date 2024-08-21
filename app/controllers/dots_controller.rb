class DotsController < ApplicationController
  after_action :verify_pundit_authorization

  def index
    @dots = policy_scope(Dot).where(notebook: current_notebook).order(display_order: :desc)
    @dots.where!(category: params[:category]) if params[:category].present?
    @dot_tasks = find_dot_tasks(@dots)
  end

  def edit
    @dot = Dot.find(params[:id])
    authorize(@dot)
  end

  def create
    @dot = build_new_dot(current_user, current_notebook, params[:category])
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

  def build_new_dot(user, notebook, category)
    max_order = Dot.where(user:).maximum(:display_order) || 0
    @dot = Dot.new(user:, display_order: max_order + 1, notebook:)
    @dot.category = category if category.present?
    @dot
  end

  def find_dot_tasks(dots)
    max_ids =
      DotTask
        .joins(:dot)
        .merge(dots.reorder(nil))
        .group(:dot_id)
        .maximum(:id)
        .values

    @dot_tasks = DotTask.where(id: max_ids).index_by(&:dot_id)
  end
end
