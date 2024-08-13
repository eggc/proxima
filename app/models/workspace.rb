class Workspace < ApplicationRecord
  belongs_to :user
  has_many :ideas
  validates :name, presence: true
end
