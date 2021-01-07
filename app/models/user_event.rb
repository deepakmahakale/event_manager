class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum rsvp_status: { rsvp_yes: 1, rsvp_no: 2, rsvp_maybe: 3 }
end
