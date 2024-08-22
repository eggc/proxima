class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError, with: :rescue_not_authorized_error
  rescue_from ActiveRecord::RecordInvalid, with: :rescue_record_invalid
  rescue_from InvalidRequestError, with: :rescue_record_invalid

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
