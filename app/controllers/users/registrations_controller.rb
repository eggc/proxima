class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |user|
      UserSetting.create!(
        user:,
        creative_tool_enabled: false,
        housework_tool_enabled: true
      )
    end
  end

  def after_inactive_sign_up_path_for(user)
    need_mail_confirmation_path(email: user.email)
  end
end
