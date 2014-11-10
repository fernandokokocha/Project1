class Announcement < ActiveRecord::Base
	belongs_to :category
	belongs_to :user
	has_many :replies

	validates :title, :content, presence: true

	accepts_nested_attributes_for :category, :user

	def to_s
		title + " (" + 	user.email + ")"
	end
end
