class Book < ApplicationRecord

	belongs_to :user

	validates :body, length: { maximum: 200 }
	validates :title, presence: true
	validates :body, presence: true

	has_many :likes, dependent: :destroy

	def like_user(user_id)
		likes.find_by(user_id: user_id)
	end
end
