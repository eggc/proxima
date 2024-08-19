class BottomNavigationComponent < ViewComponent::Base
  delegate :current_user, to: :controller, private: true

  def render?
    controller.current_user.present?
  end

  def home?
    controller.controller_name == 'houseworks' &&
      controller.action_name == 'index'
  end

  def new_item?
    controller.controller_name == 'houseworks' &&
      controller.action_name == 'new'
  end

  def user?
    controller.controller_name == 'users' &&
      controller.action_name == 'show'
  end
end
