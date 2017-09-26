class Product < ApplicationRecord
	has_many :orders

	def self.search(search_term)
		like_operator = Rails.env.development? ? 'like' : 'ilike'
		Product.where("name #{like_operator} ?", "%#{search_term}%")
	end
end
