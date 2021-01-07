class User < ApplicationRecord
  validates :username, presence: true,
                       length: { minimum: 1 },
                       uniqueness: true,
                       format: { with: /\A[A-Za-z0-9_]+\Z/, message: 'Only alphanumeric characters and _ is allowed' }
end
