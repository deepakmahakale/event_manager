class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_events
  has_many :events, through: :user_events
  has_many :owned_events, class_name: 'Event', foreign_key: :owner_id

  validates :username, presence: true,
                       length: { minimum: 1 },
                       uniqueness: true,
                       format: { with: /\A[A-Za-z0-9_.]+\Z/, message: 'Only alphanumeric characters . and _ is allowed' }, allow_blank: true

  self.per_page = 10

  def availability(from: nil, to: nil)
    from = (from&.to_date || Date.current).beginning_of_day
    to = (to&.to_date || 1.week.from_now).end_of_day

    range = (from.to_i..to.to_i).step(2.hour).map { |interval| Time.at(interval).utc }

    events.where("end_time > ? AND start_time < ?", from, to).each do |event|
      range = adjust_availability(event, range)
    end
    range.to_a
  end

  def adjust_availability(event, range)
    range.map! do |date|
      date unless event.overlap?(date, (date + 2.hours - 1.minute).end_of_hour)
    end.compact
  end
end
