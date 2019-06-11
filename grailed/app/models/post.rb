class Post < ApplicationRecord
        has_one_attached :avatar
	has_many :likes, dependent: :destroy
  	has_many :comments, dependent: :destroy
        has_many :flag_posts, dependent: :destroy
  	belongs_to :user
	#actions
	before_save :default_values
	#validates
	#validates :city, :country, :title, :description, presence: true
	#validates :security ,acceptance: {accept: ['open','closed']}
	#defs
	def default_values
		self.status = "uns" #uns--> unsolved - s-->solved
		self.visible = "yes" #"no" when the post is in the dumpster or flagged
		end

	def self.search_by(search_term)
		where("LOWER(title) LIKE :search_term OR LOWER(description) LIKE :search_term ",
		 search_term: "%#{search_term.downcase}%")
	end

	def self.change_visible(string)
		self.visible = string
	end
end
