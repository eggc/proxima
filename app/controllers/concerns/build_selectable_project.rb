module BuildSelectableProject
  private

  def build_selectable_project
    Project
      .where(user: current_user)
      .order(:display_order)
      .pluck(:title, :id)
  end
end
