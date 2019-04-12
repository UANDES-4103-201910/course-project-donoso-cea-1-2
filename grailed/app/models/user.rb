class User < ApplicationRecord
	has_many :votes
	has_many :comments
	has_many :posts
end
