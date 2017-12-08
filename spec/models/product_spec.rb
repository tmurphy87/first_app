require 'rails_helper'

describe Product do

  context "when the product has comments" do
    before do
      @product = FactoryBot.create(:product)
      @user = FactoryBot.create(:user)
      @comment1 = @product.comments.create!(rating: 1, user: @user, body: "Awful bike!")
      @comment2 = @product.comments.create!(rating: 3, user: @user, body: "Ok bike!")
      @comment3 = @product.comments.create!(rating: 5, user: @user, body: "Great bike!")
    end

    it "returns the average rating of all comments" do
    	expect(@product.average_rating).to eq 3
    end

    it "is not valid without a name" do
    	expect(Product.new(description: "Nice bike")).not_to be_valid
    end

    it "has the lowest rated comment" do
      expect(@comment1).to eq(@product.lowest_rating_comment)
    end

    it "has the highest rated comment" do
      expect(@comment3).to eq(@product.highest_rating_comment)
    end

    it "has views equal to the times viewed" do
      @product.reload
      expect("#{@product.viewed!}").to eq(@product.views)
    end
  end
end

describe Product do
  before do
      @product = FactoryBot.create(:product)
      @user = FactoryBot.create(:user)
  end

  context "when product name field is empty" do
    product = FactoryBot.create(:product)
    product.name = ""

    it "should not be valid" do
      expect(product).not_to be_valid
    end
  end

  context "when product does not have description" do
    product = FactoryBot.create(:product)
    product.description = ""

    it "should not be vaild" do
      expect(product).not_to be_valid
    end
  end

  context "when product does not have image" do
    product = FactoryBot.create(:product)
    product.image_url = ""

    it "should not be valid" do
      expect(product).not_to be_valid
    end
  end

  context "when the product has no colour" do
    product = FactoryBot.create(:product) 
    product.colour = ""

    it "should not be valid" do
      expect(product).not_to be_valid
    end
  end

  context "when the product has no price" do
    product = FactoryBot.create(:product)
    product.price = ""

    it "should not be vaild" do
      expect(product).not_to be_valid
    end
  end
end