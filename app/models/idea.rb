class Idea < ApplicationRecord
  belongs_to :user

  enum :emote, %w[blank hate love think star].to_h { [_1, _1] }, prefix: true
end
