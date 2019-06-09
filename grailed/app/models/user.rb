class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	#asociations
	has_one_attached :avatar
	has_many :votes
	has_many :comments
	has_many :posts
	#actions
	before_save :default_values
	#validates
	#validates :country, :city, presence: true
	#validates :password , length: {minimum: 5 , maximum: 12}
	#defs
	def default_values
		if self.role!="admin"
			self.role = "normal" #admin and sadmin valid too
		end
	end
	 
end
