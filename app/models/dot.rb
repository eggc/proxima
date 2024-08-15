class Dot < ApplicationRecord
  belongs_to :user
  belongs_to :workspace

  has_many :dot_tasks, dependent: :destroy

  has_many :dot_projects, dependent: :destroy
  has_many :projects, through: :dot_projects

  enum :category, %w[blank hate love think star task].to_h { [_1, _1] }, prefix: true, default: :blank

  scope :filter_by_project, ->(project) { joins(:dot_projects).merge(DotProject.where(project_id: project.id)) }

  def category_icon
    {
      'hate' => "\u{1F621}",
      'love' => "\u{2764}\u{FE0F}",
      'think' => "\u{2753}",
      'star' => "\u{2B50}"
    }[category] || ''
  end
end
