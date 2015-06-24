module EventsHelper

  def logged_by(user)
    "#{user.first_name} #{user.last_name}".titleize
  end

  def is_unread(unreads, event)  
    unreads.each do |unread|
      if event.id == unread.event_id
        return "unread"
      end
    end
  end

  def check_if_suspended(event, employee)
    if event.incident_type == "Suspension"
      if Suspension.active.find_by(employee_id: event.employee_id).present?
        true
      end
    else
      false
    end
  end

end
