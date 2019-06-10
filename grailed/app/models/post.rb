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
end
