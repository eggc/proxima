class HouseworkLog < ApplicationRecord
  belongs_to :housework

  validates :memo, length: { maximum: 1024 }
end
