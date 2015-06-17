class Employee < ActiveRecord::Base

  has_many :events, dependent: :destroy
  accepts_nested_attributes_for :events
	
  validates :first_name, :last_name, presence: true

  def self.search(search)
    where("first_name LIKE ?", "%#{search}%")
    where("last_name LIKE ?", "%#{search}%")
  end

end
