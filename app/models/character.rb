class Character < ApplicationRecord
  belongs_to :user
  has_many :project_characters
  has_many :projects, through: :project_characters

  scope :filter_by_project_id, lambda { |project_id|
    return all if project_id.blank?

    joins(:project_characters).merge(ProjectCharacter.where(project_id:))
  }
end
