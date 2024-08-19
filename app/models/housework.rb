class Housework < ApplicationRecord
  belongs_to :user
  has_many :housework_logs, dependent: :destroy

  def days_since_last_done
    if last_worked_at
      (Date.current - last_worked_at).to_i
    else
      0
    end
  end

  def update_housework_logs!(records)
    return if records.blank?
    raise ArgumentError if records.any? { _1['housework_id'].to_i != id }

    HouseworkLog.upsert_all(records)
  end
end
