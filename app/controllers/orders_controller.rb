class OrdersController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@orders = Order.all
		@orders = @orders.paginate(:page => params[:page], :per_page =>4)
	end

	def show
	end

	def new
	end

	def create
	end

	def destroy
	end
	
end