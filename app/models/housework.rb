class Housework < ApplicationRecord
  belongs_to :user
  has_many :housework_logs
end
