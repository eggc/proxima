class DotTask < ApplicationRecord
  def toggle!
    if is_completed
      update!(is_completed: false, completed_at: nil)
    else
      update!(is_completed: true, completed_at: Time.current)
    end
  end
end
