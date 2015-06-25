class Employee < ActiveRecord::Base

  has_many :events, dependent: :destroy
  accepts_nested_attributes_for :events
	
  validates :first_name, :last_name, :pid, presence: true
  validates :pid, length: { is: 5 }, uniqueness: true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  def self.search(search)
    scope = all.active if search[2].nil?
    scope = all.inactive unless search[2].nil?
    scope = scope.where("first_name like ?", "%#{search[0]}%") unless search[0].empty?
    scope = scope.where("last_name like ?", "%#{search[1]}%") unless search[1].empty?
    scope
  end


end
