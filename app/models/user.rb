class User < ActiveRecord::Base
	
	AUTHORISATION_LEVEL = [ "QA", "SUPERVISOR", "ADMIN" ]
	
	before_save { first_name.downcase! }
	before_save { last_name.downcase! }
	before_save { username.downcase! }
	before_save { authority.downcase! }
	
  validates :first_name,  presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :authority, presence: true
  validates :password, length: { minimum: 6 }, :on => :create
  
  has_secure_password
  has_many :events
  has_many :unreads

end
