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
end
