class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum rsvp_status: { rsvp_yes: 1, rsvp_no: 2, rsvp_maybe: 3 }

  validate :overlapping_events

  private

  def overlapping_events
    if rsvp_yes?
      event_ids = user.events.where('start_time <= ? AND ? >= end_time', event.end_time, event.start_time).where.not(id: event).pluck(:id)
      UserEvent.where(event_id: event_ids).each do |user_event|
        user_event.rsvp_no!
      end
    end
  end
end
