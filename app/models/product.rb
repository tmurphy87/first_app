class Product < ApplicationRecord
	has_many :orders

	validates :name, :price, :image_url, :color, presence: true

	def self.search(search_term)
		Product.where("name ILIKE ?", "%#{search_term}%")
	end
end
