class Idea < ApplicationRecord
  belongs_to :user
  has_many :idea_projects, dependent: :destroy
  has_many :projects, through: :idea_projects

  enum :emote, %w[blank hate love think star].to_h { [_1, _1] }, prefix: true

  scope :filter_by_project, ->(project) { joins(:idea_projects).merge(IdeaProject.where(project_id: project.id)) }

  def emote_icon
    {
      'hate' => "\u{1F621}",
      'love' => "\u{2764}\u{FE0F}",
      'think' => "\u{2753}",
      'star' => "\u{2B50}"
    }[emote] || ''
  end
end
