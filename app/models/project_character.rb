class ProjectCharacter < ApplicationRecord
  belongs_to :project
  belongs_to :character
end
