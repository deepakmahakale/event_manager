class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum rsvp_status: { rsvp_yes: 1, rsvp_no: 2, rsvp_maybe: 3 }

  validate :reject_overlapping_events

  self.per_page = 10

  private

  def reject_overlapping_events
    if rsvp_yes?
      # We can update_all as well
      user.user_events.where(event_id: overlapping_events.pluck(:id)).each do |user_event|
        user_event.rsvp_no!
      end
    end
  end

  def overlapping_events
    user.events.overlapping(event.start_time, event.end_time)
        .where.not(id: event)
  end
end
