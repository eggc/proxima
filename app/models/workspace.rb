class Workspace < ApplicationRecord
  belongs_to :user
  has_many :dots
  validates :name, presence: true
end
