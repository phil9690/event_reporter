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

  def check_for_suspension(event, employee)
    if event.incident_type == "Suspension"
      if Suspension.active.find_by(employee_id: event.employee_id).present?
        flash.now[:danger] = "This employee is currently suspended"
        render 'new'
      else
        Suspension.create(employee_id: event.employee_id, event_id: event.id)
        redirect_to employee_event_path(employee, event)
      end
    else
      redirect_to employee_event_path(employee, event)
    end
  end

end
