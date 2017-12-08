class OrdersController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@user = current_user
		if user_signed_in? && @user.admin?
		  @orders = Order.all
		  @orders = @orders.paginate(:page => params[:page], :per_page =>4)
		elsif user_signed_in?
			@orders = @user.orders
			@orders = @orders.paginate(:page => params[:page], :per_page =>4)
		end
	end

	def show
	end

	def new
		@order = Order.new
	end

	def create
		@order = current_user
		@order = Order.create(order_params)
		respond_with @order
	end

	def destroy
	end

private
  
  def order_params
  	params.require(:order).permit(:product_id, :user_id, :total, :product_image_url, :email)
  end
	
end