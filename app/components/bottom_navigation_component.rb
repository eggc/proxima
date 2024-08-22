class BottomNavigationComponent < HeaderComponent
  def render?
    current_user.present?
  end

  def houseworks?
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
