class Project < ApplicationRecord
  belongs_to :user
  has_many :project_characters
  has_many :characters, through: :project_characters
  has_many :project_parts
  has_many :dot_projects, dependent: :destroy
  has_many :dots, through: :dot_projects

  enum :media, %w[unspecified movie anime comic game novel].to_h { [_1, _1] }, prefix: true
  enum :visibility, %w[private public].to_h { [_1, _1] }, prefix: true

  scope :public_or_owned_by, ->(user) { where(user:).or(visibility_public) }
end
