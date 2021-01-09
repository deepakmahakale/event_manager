module ApplicationHelper
  def event_owner?(event)
    event.owner == current_user
  end
end
