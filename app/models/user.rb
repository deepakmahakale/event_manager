class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events

  validates :username, presence: true,
                       length: { minimum: 1 },
                       uniqueness: true,
                       format: { with: /\A[A-Za-z0-9_]+\Z/, message: 'Only alphanumeric characters and _ is allowed' }
end
