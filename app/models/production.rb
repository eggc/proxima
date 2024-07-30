class Production < ApplicationRecord
  belongs_to :user

  enum :media, %w[unspecified movie anime comic game novel].to_h { [_1, _1] }, prefix: true
end
