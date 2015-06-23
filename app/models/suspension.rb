class Suspension < ActiveRecord::Base
  belongs_to :employee
  belongs_to :event

  scope :expired, ->  { where("DATE(created_at) < DATE(?)", Date.today - 1.week) }
end
