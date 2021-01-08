json.extract! event, :id, :title, :start_time, :end_time, :description, :all_day, :created_at, :updated_at
json.url event_url(event, format: :json)
