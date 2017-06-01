class User < ApplicationRecord
  paginates_per 20

  validates :name, :email, :last_visit_at, presence: true
  validates :level, numericality: { greater_than: 0 }, presence: true

  belongs_to :game
  has_many :mails, class_name: 'MailUser'
end
