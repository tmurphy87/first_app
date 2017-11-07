if Rails.env.production?
	Rails.configuration.stripe = {
		publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
		secret_key: ENV['STRIPE_SECRET_KEY']
	}
else
	Rails.configuration.stripe = {
		publishable_key: 'pk_test_XSS9MAnMTdTKK3nfexLSXyN5',
		secret_key: 'sk_test_yxuWitHbhEyV3xjs7tu23fmV'
	}
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]