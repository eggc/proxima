class HeaderComponent < ViewComponent::Base
  delegate :current_user,
           :current_workspace,
           to: :controller,
           private: true

  MenuItem = Data.define(:name, :path)

  def menu_items
    return [] if current_user.nil?

    menu_items = []
    menu_items << MenuItem.new('Tree', tree_path) if creative_tool_enabled?
    menu_items << MenuItem.new('Dots', dots_path) if creative_tool_enabled?
    menu_items << MenuItem.new('User', user_path)
  end

  def header_context
    @header_context = {
      workspaces: Workspace.where(user: current_user).order(:display_order)
    }
  end

  private

  def creative_tool_enabled?
    current_user.user_setting.creative_tool_enabled
  end
end
