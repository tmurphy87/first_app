class UserMailer < ApplicationMailer
	default from: "from@example.com"

	def contact_form(email, name, message)
	@message = message
	    mail(from: email,
	    	to: 'demowebapp3@gmail.com',
	    	subject: "A new contact form message from #{name}")		
	end

	def welcome(user)
		@appname = "First App"
		mail(to: user.email,
			subject: "Welcome to #{@appname}!")
	end

	def payment_confirmation(user, product)
		byebug
		@user = user
		@product = product
		mail(to: user.email, 
			subject: "Payment confirmation")
	end
end

