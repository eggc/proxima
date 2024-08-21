class PagesController < ApplicationController
  after_action :verify_pundit_authorization

  def index
    @pages = policy_scope(Page).where(notebook: current_notebook).order(display_order: :desc)
    @pages.where!(category: params[:category]) if params[:category].present?
    @page_tasks = find_page_tasks(@pages)
  end

  def edit
    @page = Page.find(params[:id])
    authorize(@page)
  end

  def create
    @page = build_new_page(current_user, current_notebook, params[:category])
    authorize(@page)
    @page.save!
    redirect_back_or_to(pages_path)
  end

  def update
    @page = Page.find(params[:id])
    authorize(@page)
    @page.update!(page_params)
    redirect_to(pages_path)
  end

  def destroy
    @page = Page.find(params[:id])
    authorize(@page)
    @page.destroy!
    redirect_to(pages_path)
  end

  private

  def page_params
    params.require(:page).permit(:content, :category, :display_order)
  end

  def build_new_page(user, notebook, category)
    max_order = Page.where(user:).maximum(:display_order) || 0
    @page = Page.new(user:, display_order: max_order + 1, notebook:)
    @page.category = category if category.present?
    @page
  end

  def find_page_tasks(pages)
    max_ids =
      PageTask
        .joins(:page)
        .merge(pages.reorder(nil))
        .group(:page_id)
        .maximum(:id)
        .values

    @page_tasks = PageTask.where(id: max_ids).index_by(&:page_id)
  end
end
