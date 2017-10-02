class Product < ApplicationRecord
	has_many :orders
	has_many :comments

	validates :name, :price, :image_url, :color, presence: true

	def self.search(search_term)
		Product.where("name ILIKE ?", "%#{search_term}%")
	end

	def highest_rating_comment
		comments.rating_desc.first
	end

	def lowest_rating_comment
		comments.rating_asc.first
	end
end
