class Housework < ApplicationRecord
  belongs_to :user
  has_many :housework_logs, dependent: :destroy

  def days_since_last_done
    if housework_logs.present?
      (Date.current - housework_logs.maximum(:worked_at)).to_i
    else
      0
    end
  end
end
