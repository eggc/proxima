class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(user)
    UserSetting.create!(
      user:,
      creative_tool_enabled: true,
      housework_tool_enabled: false
    )

    workspace = Workspace.create!(user:, name: 'default workspace', display_order: 1)
    cookies[:current_workspace_id] = workspace.id

    root_path
  end
end
