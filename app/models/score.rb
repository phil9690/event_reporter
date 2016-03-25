class Score < ActiveRecord::Base
  belongs_to :employee
  belongs_to :user
  belongs_to :job
end
