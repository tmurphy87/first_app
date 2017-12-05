class Product < ApplicationRecord
	has_many :orders
	has_many :comments

	validates :name, presence: true
	validates :price, numericality: true
	validates :image_url, presence: true
	validates :colour, presence: true
	validates :description, presence: true

	def self.search(search_term)
		Product.where("name ILIKE ?", "%#{search_term}%")
	end

	def highest_rating_comment
		comments.rating_desc.first
	end

	def lowest_rating_comment
		comments.rating_asc.first
	end

	def average_rating
		comments.average(:rating).to_f
	end

	def views
		$redis.get("product:#{id}") #Equal to 'GET product:1'
	end

	def viewed!
		$redis.incr("product:#{id}") #Equal to 'INC product:1'
	end
end
