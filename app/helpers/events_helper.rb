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
	     
#		params[:action] == action && params[:controller] == controller ? "active" : nil        
#	end
	

end
