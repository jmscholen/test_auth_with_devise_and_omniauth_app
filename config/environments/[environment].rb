#Email

config.action_mailer.delivery_method = :smtp
config.action_mailer.perform_deliveries = true
config.action_mailer.default_options = { from: 'jmscholen+devise@gmail.com' }
config.action_mailer.smtp_settings = {
	address: 'smtp.gmail.com',
	port '587',
	enable_starttls_auto: true,
	user_name: 'Rails.application.secrets.private_email',
	password: 'Rails.applicaiton.secrets.private_pw',
	authentication => :plain,
	domain => 'gmail.com'
}
config.action_mailer.raise_delivery_errors = true