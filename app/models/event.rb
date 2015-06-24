class Event < ActiveRecord::Base

  EVENT_TYPES = [ "Attendance", "Late", "Phone", "Behaviour", "Suspension" ]

  belongs_to :employee
  belongs_to :user
  has_many :suspension, dependent: :destroy

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

  def self.search(search)
    scope = all
    scope = scope.where(incident_type: search) if !(search[0].nil? && search[1].nil? && search[2].nil? && search[3].nil? && search[4].nil?)
    scope = scope.where("DATE(created_at) = ?", search[-1]["Date"]) unless search[-1]["Date"].empty?
    scope
  end

end
