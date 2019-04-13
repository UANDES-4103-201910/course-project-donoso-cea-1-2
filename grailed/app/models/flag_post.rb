class FlagPost < ApplicationRecord
  belongs_to :user
  belongs_to :post
	validates :reason, presence: true
	
end
