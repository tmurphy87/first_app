require 'rails_helper'

describe UsersController, type: :controller do
	
	before do
		@user = FactoryBot.create(:user)
		@user2 = FactoryBot.create(:user)
		#@user = User.create!(email: "demo1@gmail.com", password: "testpass")
		#@user2 = User.create!(email: "user2@gmail.com", password: "test123")
	end

	describe "GET #show" do

		context "user is logged in" do
			before do
				sign_in @user
			end

			it "loads correct user details" do
				get :show, params: { id: @user.id }
				expect(assigns(:user)).to eq @user
				expect(response).to have_http_status(200)
			end
		end

		context "user is not logged in" do
			it "redirects to login" do
				get :show, params: { id: @user.id }
				expect(response).to redirect_to(root_path)
		  end
		end

		context "user cannot see other user show page" do
			before do
				sign_in @user2
			end

		  it "redirects to root path" do
			  get :show, params: { id: @user.id }
			  expect(response).to redirect_to(root_path)
			end
	  end
	end
end