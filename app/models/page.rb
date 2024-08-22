class Page < ApplicationRecord
  belongs_to :notebook

  has_many :page_tasks, dependent: :destroy

  has_many :page_projects, dependent: :destroy
  has_many :projects, through: :page_projects

  enum :category, %w[blank hate love think star task].to_h { [_1, _1] }, prefix: true, default: :blank

  scope :filter_by_project, ->(project) { joins(:page_projects).merge(PageProject.where(project_id: project.id)) }

  def user_id
    notebook&.user_id
  end

  def category_icon
    {
      'hate' => "\u{1F621}",
      'love' => "\u{2764}\u{FE0F}",
      'think' => "\u{2753}",
      'star' => "\u{2B50}"
    }[category] || ''
  end
end
