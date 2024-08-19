class Housework < ApplicationRecord
  belongs_to :user
  has_many :housework_logs, dependent: :destroy

  validates :content, presence: true, length: { maximum: 1024 }

  def days_since_last_done
    return unless last_worked_at

    (Date.current - last_worked_at).to_i
  end

  def update_housework_logs!(records)
    return if records.blank?
    raise ArgumentError if records.any? { _1['housework_id'].to_i != id }

    HouseworkLog.upsert_all(records)
  end

  def save_last_worked_at!
    return unless housework_logs.any?

    update!(last_worked_at: housework_logs.maximum(:worked_at))
  end
end
