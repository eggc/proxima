class HeaderComponent < ViewComponent::Base
  delegate :current_user,
           :current_workspace,
           to: :controller,
           private: true

  MenuItem = Data.define(:name, :path)

  def menu_items
    if current_user
      [
        *creative_tool_menu_items,
        *housework_tool_menu_items,
        MenuItem.new('User', user_path)
      ]
    else
      []
    end
  end

  def header_context
    @header_context = {
      workspaces: Workspace.where(user: current_user).order(:display_order)
    }
  end

  private

  def creative_tool_menu_items
    if current_user.user_setting.creative_tool_enabled
      [
        MenuItem.new('Tree', tree_path),
        MenuItem.new('Dots', dots_path)
      ]
    else
      []
    end
  end

  def housework_tool_menu_items
    if current_user.user_setting.housework_tool_enabled
      [MenuItem.new('Housework', houseworks_path)]
    else
      []
    end
  end
end
