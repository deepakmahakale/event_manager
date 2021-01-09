class Event < ApplicationRecord
  has_many :user_events
  has_many :users, through: :user_events
  enum status: { upcoming: 0, ongoing: 1, completed: 2 }

  accepts_nested_attributes_for :user_events

  before_save :update_event_status

  validates_presence_of :start_time, :title
  validates_presence_of :end_time, unless: -> { all_day? }

  validate :correct_event_time

  private

  def update_event_status
    self.status = :completed if end_time.past?
  end

  def correct_event_time
    if start_time.present? && end_time.present? && start_time < end_time
      true
    else
      errors.add(:start_time, 'start_time should be less than end_time')
    end
  end
end
