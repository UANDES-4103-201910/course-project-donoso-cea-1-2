class User < ApplicationRecord
	#asociations
	has_many :votes
	has_many :comments
	has_many :posts
	#actions
	before_save :default_values
	#validates
	validates :country, :name, :city, presence: true
	validates :password , length: {minimum: 5 , maximum: 12}
	#defs
	def default_values
		self.role = "normal" #admin and sadmin valid too
		end
	 
end
