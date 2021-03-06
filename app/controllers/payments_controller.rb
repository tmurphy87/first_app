class PaymentsController < ApplicationController
  before_action :authenticate_user!

	def create 
		#byebug
		token = params[:stripeToken]
		@product = Product.find(params[:product_id])
		@user = current_user
		#Create the charge on Stripe's servers 
		begin
			charge = Stripe::Charge.create(
				amount: (@product.price*100).to_i,
				currency: "usd",
				source: token,
				description: params[:stripeEmail]
				)
			  if charge.paid
			    Order.create(product_id: @product.id, user_id: @user.id, total: @product.price)
			    UserMailer.payment_confirmation(@user, @product).deliver_now
			    redirect_to product_path(@product), notice: "Thank you for your order"
		    end

		    flash[:success] = "Payment processed successfully"

		rescue Stripe::CardError => e 
			#This card has been declined
			body = e.json_body
			err = body[:error]
			flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
			redirect_to new_charge_path
	  end
	end
end
