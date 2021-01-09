class Event < ApplicationRecord
  has_many :user_events
  has_many :users, through: :user_events
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id, optional: true

  accepts_nested_attributes_for :user_events

  before_save :update_event_status

  validates_presence_of :start_time, :title
  validates_presence_of :end_time, unless: -> { all_day? }

  validate :correct_event_time

  enum status: { upcoming: 0, ongoing: 1, completed: 2 }

  scope :overlapping, ->(from, to) { where('start_time < ? AND ? < end_time', to, from) }

  self.per_page = 10

  def overlap?(from, to)
    start_time < to && from < end_time
  end

  private

  def update_event_status
    self.status = :completed if end_time.past?
  end

  def correct_event_time
    if start_time.present? && end_time.present? && start_time < end_time
      true
    else
      errors.add(:start_time, 'should be less than end_time')
    end
  end
end
