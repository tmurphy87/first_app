require 'rails_helper'

describe User do
	context "testing validations" do

		it "will not validate" do
			expect(User.new(first_name: "Tiffany", last_name: "Murphy", email: "demowebapp3@gmail.com")).not_to be_valid
		end
	end
end