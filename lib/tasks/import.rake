require 'csv'

RSVP_MAPPING = {
  'yes' => 'rsvp_yes',
  'no' => 'rsvp_no',
  'maybe' => 'rsvp_maybe'
}.freeze

def add_users_to_event(event, raw_users)
  return if raw_users.nil?

  raw_users.split(';').each do |user_data|
    username, rsvp = user_data.split('#')
    # We can also use first_or_create
    # user = User.where(username: username).first_or_create

    user = User.find_by(username: username)

    puts "No user with username #{username}" and next unless user

    user_event = UserEvent.where(user: user, event: event).first_or_initialize
    user_event.rsvp_status = UserEvent.rsvp_statuses[RSVP_MAPPING[rsvp]]
  end
end

namespace :import do
  task users: :environment do
    #
    # Use activerecord-bulk upload
    #
    CSV.foreach('public/users.csv',
                headers: true, header_converters: :symbol) do |row|

      User.create(row.to_h.slice(:username, :email, :phone))
    end
  end

  task events: :environment do
    CSV.foreach('public/events.csv',
                headers: true, header_converters: :symbol) do |row|

      event = Event.create(
        title: row[:title],
        start_time: row[:starttime],
        end_time: row[:endtime],
        description: row[:description],
        all_day: row[:allday]
      )
      add_users_to_event(event, row[:usersrsvp])
    end
  end
end
