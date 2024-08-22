class HeaderComponent < ViewComponent::Base
  delegate :current_user, to: :controller, private: true

  MenuItem = Data.define(:name, :path, :icon) do
    def active?
      false
    end
  end


  def menu_items
    if current_user
      [
        *creative_tool_menu_items,
        *housework_tool_menu_items,
        MenuItem.new(I18n.t('nav.user'), user_path, :user)
      ]
    else
      []
    end
  end

  def header_context
    @header_context = {
      notebooks: Notebook.where(user: current_user).order(:display_order)
    }
  end

  private

  def creative_tool_menu_items
    if current_user.user_setting.creative_tool_enabled
      [
        MenuItem.new(I18n.t('nav.notebooks'), notebooks_path, :note)
      ]
    else
      []
    end
  end

  def housework_tool_menu_items
    if current_user.user_setting.housework_tool_enabled
      [
        MenuItem.new(I18n.t('nav.houseworks'), houseworks_path, :house),
        MenuItem.new(I18n.t('nav.new_housework'), new_housework_path, :plus)
      ]
    else
      []
    end
  end
end
