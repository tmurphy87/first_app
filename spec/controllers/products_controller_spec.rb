require 'rails_helper'

describe ProductsController, type: :controller do

	#index
  context "GET #index" do
    it "renders the index page" do 
      get :index
      expect(response).to be_ok
      expect(response).to render_template('index')
    end

    it "renders the search template" do
    	get :index, params: {q: "test"}
    	expect(response).to be_ok
    	expect(response).to render_template('index')
    end

    it "searches with a parameter" do
    	get :index, params: {search_term: "race"}
    	expect(response).to be_successful
    end
  end

  #show action
  context "GET #show" do
    it "renders the show page" do 
      @product = FactoryBot.create(:product)
      get :show, params: {id: @product}
      expect(response).to be_ok
      expect(response).to render_template('show')
    end
  end

  #new
  context "GET #new" do
  	it "will not be valid for non-admin" do
  	  @product = FactoryBot.create(:product)
  	  get :new, params: {id: @product}
  	  expect(response).to_not be_successful
  	end
  end

  context "GET #new" do
  	before do
  		@admin = FactoryBot.create(:admin)
  		sign_in @admin
  	end

  	it "renders new template for admin" do
  		@product = FactoryBot.create(:product)
  		get :new, params: {id: @product}
  		expect(response).to be_successful
  	end
  end

  #edit 
  context "GET #edit" do
    it "will not be valid for non-admin" do
      @product = FactoryBot.create(:product)
      get :edit, params: {id: @product}
      expect(response).to_not be_successful
    end
  end

  context "GET #edit" do
    before do
    	@admin = FactoryBot.create(:admin)
    	@product = FactoryBot.create(:product)
    	sign_in @admin
    end
    it "renders edit template for admin" do
    	get :edit, params: {id: @product}
    	expect(response).to be_successful
    end
  end 

  #create action
  context "POST #create" do
    before do 
      @admin = FactoryBot.create(:admin)
      sign_in @admin
    end
    it "successfully creates new product" do  
      @product = FactoryBot.create(:product)
      expect(response).to be_successful
    end
    it "cannot create a product" do 
       expect(Product.new(price:nil)).not_to be_valid
    end  
  end  

  #update 
  context "put #update" do
    before do 
      @product = FactoryBot.create(:product)
      @admin = FactoryBot.create(:admin)
      sign_in @admin
    end
    it "successfully updates a product" do
      @update = { name:@product.name, image_url:"images.com", id:@product.id, price:@product.price, colour: "anything"}
      put :update, params: { id: @product.id, product: @update}
      @product.reload
      expect(@product.colour).to eq "anything"
    end
  end

  #delete 
  context "destroy" do 
    before do 
      @product = FactoryBot.create(:product)
      @admin = FactoryBot.create(:admin)
      sign_in @admin
    end
    it "allows admin to delete a product" do 
      delete :destroy, params: {id: @product}
      expect(response).to redirect_to products_path
    end
  end 
end


  