FactoryBot.define do
	sequence (:product) { |n| "product#{n}" }
	sequence (:comment) { |n| "comment#{n}" }
  sequence (:image_url) { |n| "cup#{n}-11.jpg"}

	factory :product do
		name "anything"
		description "anything"
		price "100"
		colour "anything"
		image_url "example.jpg"
	end

	factory :comment do
		user_id "1"
		body "Great Bike"
		rating "5"
		product_id "1"
	end
end