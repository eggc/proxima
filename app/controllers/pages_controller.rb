class PagesController < ApplicationController
  after_action :verify_pundit_authorization

  def index
    @pages = policy_scope(Page).order(display_order: :desc)

    if params[:notebook_id]
      @notebook = Notebook.find(params[:notebook_id]).then { authorize(_1) }
      @pages.where!(notebook: @notebook)
    end

    @pages.where!(category: params[:category]) if params[:category].present?
    @page_tasks = find_page_tasks(@pages)
  end

  def edit
    @page = Page.find(params[:id])
    authorize(@page)
  end

  def create
    @page = build_new_page(params[:notebook_id], params[:category])
    authorize(@page)
    @page.save!
    redirect_back_or_to(notebook_pages_path(@page.notebook))
  end

  def update
    @page = Page.find(params[:id])
    authorize(@page)
    @page.update!(page_params)
    redirect_to(notebook_pages_path(@page.notebook))
  end

  def destroy
    @page = Page.find(params[:id])
    authorize(@page)
    @page.destroy!
    redirect_back_or_to(notebook_pages_path(@page.notebook))
  end

  private

  def page_params
    params.require(:page).permit(:content, :category, :display_order)
  end

  def build_new_page(notebook_id, category)
    max_order = Page.where(notebook_id:).maximum(:display_order) || 0
    @page = Page.new(display_order: max_order + 1, notebook_id:)
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
