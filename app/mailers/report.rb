class Report < ApplicationMailer
  
  def daily_report
    @events = Event.where("created_at >= ?", Time.zone.now.beginning_of_day)
    @today = Date.today.strftime('%d/%m/%Y')
    mail(to: "supervisors@populusdatasolutions.com", subject: "Events for #{@today}")
  end
end
