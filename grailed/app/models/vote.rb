class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post
	validates :vote, presence: true
end
