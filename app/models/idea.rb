class Idea < ApplicationRecord
  belongs_to :user
  has_many :idea_projects
  has_many :projects, through: :idea_projects

  enum :emote, %w[blank hate love think star].to_h { [_1, _1] }, prefix: true

  def emote_icon
    {
      'hate' => "\u{1F621}",
      'love' => "\u{2764}\u{FE0F}",
      'think' => "\u{2753}",
      'star' => "\u{2B50}"
    }[emote] || ''
  end
end
