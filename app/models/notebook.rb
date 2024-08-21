class Notebook < ApplicationRecord
  belongs_to :user
  has_many :pages
  validates :name, presence: true
end
