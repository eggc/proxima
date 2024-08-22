class UserSettingsController < ApplicationController
  def update
    @user = current_user
    @user.user_setting.update!(user_setting_params)

    redirect_to(user_path)
  end

  private

  def user_setting_params
    params.require(:user_setting).permit(:housework_tool_enabled, :creative_tool_enabled)
  end
end
