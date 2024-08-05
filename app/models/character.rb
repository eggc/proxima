class Character < ApplicationRecord
  belongs_to :user
  has_many :project_characters
  has_many :projects, through: :project_characters
end
