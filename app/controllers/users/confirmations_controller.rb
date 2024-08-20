class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    super do |user|
      sign_in(user)
    end
  end
end
