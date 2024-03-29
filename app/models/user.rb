class User < ActiveRecord::Base
	TEMP_EMAIL = 'change@me.com'
	TEMP_EMAIL_REGEX =/change@me.com/
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,  :omniauthable 

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def self.find_for_oauth(auth, signed_in_resource = nil)
   	#get identity of user if they exist
   	identity = Identity.find_for_oauth(auth)
   	user = identity.user ? identity.user : signed_in_resource

   	#create user if needed
   	if user.nil?

      # Get the existing user by email if the provider gives us a verified email
      # If the email has not been verified by the provider we will assign the
      # TEMP_EMAIL and get the user to verify it via UsersController.add_email
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first() if email
      #create user is its a new registration
      if user.nil?
      	user = User.new(
      		name: auth.extra.raw_info.name,
      		#username: auth.info.nickname || auth.uid,
      		email: email ? email : TEMP_EMAIL,
      		password: Devise.friendly_token[0,20]
      		)
      	user.skip_confirmation!
      	user.save!
      end
  	end
  end
end
