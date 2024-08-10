class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :rescue_not_authorized_error

  helper_method :current_project

  def current_project
    @current_project ||=
      Project.where(user: current_user).find_by(id: cookies[:current_project_id]) ||
      Project.where(user: current_user).order(:display_order).first
  end

  private

  def rescue_not_authorized_error
    flash[:alert] = 'You are not authorized to perform this action.'
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
