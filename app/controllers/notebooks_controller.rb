class NotebooksController < ApplicationController
  after_action :verify_pundit_authorization

  def index
    @notebooks = policy_scope(Notebook).order(:display_order)
  end

  def show
    @notebook = Notebook.find(params[:id])
    authorize(@notebook)
  end

  def new
    max_order = Notebook.where(user: current_user).maximum(:display_order) || 0
    @notebook = Notebook.new(user: current_user, display_order: max_order + 1)
    authorize(@notebook)
  end

  def edit
    @notebook = Notebook.find(params[:id])
    authorize(@notebook)
  end

  def create
    @notebook = Notebook.new(user: current_user)
    authorize(@notebook)
    @notebook.update!(notebook_params)
    redirect_to(notebooks_path)
  end

  def update
    @notebook = Notebook.find(params[:id])
    authorize(@notebook)
    @notebook.update!(notebook_params)
    redirect_to(notebooks_path)
  end

  def destroy
    @notebook = Notebook.find(params[:id])
    authorize(@notebook)
    @notebook.destroy!
    redirect_to(notebooks_path)
  end

  private

  def notebook_params
    params.require(:notebook).permit(:name, :display_order)
  end
end
