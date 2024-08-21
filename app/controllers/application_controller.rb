class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :rescue_not_authorized_error
  rescue_from ActiveRecord::RecordInvalid, with: :rescue_record_invalid
  rescue_from InvalidRequestError, with: :rescue_record_invalid

  helper_method :current_notebook

  def current_notebook
    @current_notebook ||=
      Notebook.where(user: current_user).find_by(id: cookies[:current_notebook_id]) ||
      Notebook.where(user: current_user).order(:display_order).first
  end

  private

  def rescue_not_authorized_error
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back_or_to(root_path)
  end

  def rescue_record_invalid(e)
    flash[:alert] = e.message
    redirect_back_or_to(root_path)
  end

  def verify_pundit_authorization
    if action_name == 'index'
      verify_policy_scoped
    else
      verify_authorized
    end
  end
end
