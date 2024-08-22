class PagesController < ApplicationController
  after_action :verify_pundit_authorization

  def index
    @pages = policy_scope(Page).order(:display_order)

    if params[:notebook_id]
      @notebook = Notebook.find(params[:notebook_id]).then { authorize(_1) }
      @pages.where!(notebook: @notebook)
    end

    @pages.where!(category: params[:category]) if params[:category].present?
  end

  def new
    notebook_id = params[:notebook_id]
    max_order = Page.where(notebook_id:).maximum(:display_order) || 0
    @page = Page.new(display_order: max_order + 1, notebook_id:)
    authorize(@page)
  end

  def edit
    @page = Page.find(params[:id])
    authorize(@page)
  end

  def create
    @page = Page.new(notebook_id: params[:notebook_id])
    @page.attributes = page_params
    authorize(@page)
    @page.save!
    redirect_to(notebook_pages_path(@page.notebook))
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
    redirect_to(notebook_pages_path(@page.notebook))
  end

  private

  def page_params
    params.require(:page).permit(:content, :category, :display_order, :notebook_id)
  end
end
