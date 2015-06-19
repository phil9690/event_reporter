class Employee < ActiveRecord::Base

  has_many :events, dependent: :destroy
  accepts_nested_attributes_for :events
	
  validates :first_name, :last_name, presence: true

  def self.search(search)
    scope = all
    scope = scope.where(first_name: search) unless search[0].empty?
    scope = scope.where(last_name: search) unless search[1].empty?
    scope
  end


end
