class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :ensure_valid_email

  def ensure_valid_email
  	# Ensure we font go into an infinite loop
  	return if action_name == 'add_email'

  	# if eamil address was the temporarliy assigned one,
  	#redirect the user to the 'add_email' page
  	if current_user && (!current_user.email || current_user.email == User::TEMP_EMAIL)
  		redirect_to add_user_email_path(current_user)
  	end
  end
end
