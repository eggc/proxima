class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :rescue_not_authorized_error
  rescue_from ActiveRecord::RecordInvalid, with: :rescue_record_invalid

  helper_method :current_workspace, :header_context

  def current_workspace
    @current_workspace ||=
      Workspace.where(user: current_user).find_by(id: cookies[:current_workspace_id]) ||
      Workspace.where(user: current_user).order(:display_order).first
  end

  def header_context
    @header_context = {
      workspaces: Workspace.where(user: current_user).order(:display_order)
    }
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
