class Event < ActiveRecord::Base

  EVENT_TYPES = [ "Attendance", "Late", "Phone", "Behaviour", "Suspension" ]

  belongs_to :employee
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :employee_id, presence: true
  validates :incident_type, presence: true
  validates :description, presence: true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["First name", "Last name", "Type", "Description", "Date", "Time", "Logged By"]
      all.each do |event|
        csv << [event.employee.first_name, event.employee.last_name, event.incident_type, event.description, event.created_at.strftime("%d/%m/%Y"), event.created_at.strftime("%H:%M:%S"), "#{event.user.first_name} #{event.user.last_name}".titleize]
      end
    end
  end

  def self.search(search_params)
    type_search = search_params.except(:event_date)
    event_date = search_params[:event_date][0]
    scope = all
    scope = scope.where(incident_type: type_search.values) unless type_search.empty?
    scope = scope.where("DATE(created_at) = ?", event_date) unless event_date.empty?
    scope
  end

end
