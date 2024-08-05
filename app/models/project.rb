class Project < ApplicationRecord
  belongs_to :user
  has_many :project_characters
  has_many :characters, through: :project_characters

  enum :media, %w[unspecified movie anime comic game novel].to_h { [_1, _1] }, prefix: true
end
