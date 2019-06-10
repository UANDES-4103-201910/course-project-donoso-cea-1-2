class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable , :omniauth_providers => [ :google_oauth2 ]
	#asociations
	has_one_attached :avatar
	has_many :likes, dependent: :destroy
	has_many :comments
	has_many :posts
        has_many :flag_pos
	#actions
	before_save :default_values
	#validates
	#validates :country, :city, presence: true
	#validates :password , length: {minimum: 5 , maximum: 12}
	#defs
	def self.search_by(search_term)
		where("LOWER(name) LIKE :search_term OR LOWER(email) LIKE :search_term OR LOWER(lastname) LIKE :search_term",
		 search_term: "%#{search_term.downcase}%")
	end	

	def default_values
		if self.role!="admin"
			self.role = "normal" #admin and sadmin valid too
		end
	end
	
	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	     user.provider = auth.provider
	     user.uid = auth.uid
	     user.email= auth.info.email
	     user.password = Devise.friendly_token[0,20]
	  end	
	end
	
end
