class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_events
  has_many :events, through: :user_events

  validates :username, presence: true,
                       length: { minimum: 1 },
                       uniqueness: true,
                       format: { with: /\A[A-Za-z0-9_]+\Z/, message: 'Only alphanumeric characters and _ is allowed' }
end
