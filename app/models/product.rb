class Product < ApplicationRecord
	has_many :orders

	validates :name, :price, :image_url, :color, presence: true

	def self.search(search_term)
		Product.where("lower(name) LIKE lower(?)", "%#{search_term}")
	end
end
