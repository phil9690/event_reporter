class Suspension < ActiveRecord::Base
  belongs_to :employee

  scope :expired, ->  { where("DATE(created_at) < DATE(?)", Date.today - 1.week) }
end
