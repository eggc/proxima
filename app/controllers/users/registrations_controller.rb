class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(user)
    project = Project.create!(user:, title: 'default project', display_order: 1)
    cookies[:current_project_id] = project.id

    root_path
  end
end
