class Game < ApplicationRecord
  paginates_per 20

  validates :name, :send_from, presence: true
  validates :send_from, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  has_many :users, dependent: :destroy
end
