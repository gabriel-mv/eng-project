class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  ###Gabriel
  devise :omniauthable, :omniauth_providers => [:google_oauth2]
  ###

	def self.create_with_omniauth(auth)
	  user = find_or_create_by(uid: auth.uid, provider:  auth.provider)
	  user.email =  auth.info.email
	  user.email ||= "#{auth.uid}@#{auth.provider}.com"
	  user.password = auth.uid
	  user.first_name = auth.info.first_name
	  user.last_name = auth.info.last_name
	  user.save!
	  user
	end

	###Gabriel
	def self.from_omniauth(access_token)
  		data = access_token.info
  		user = User.where(:email => data["email"]).first

  		unless user
    		password = Devise.friendly_token[0,20]
    		user = User.create(first_name: data["first_name"], email: data["email"],
      			password: password#, password_confirmation: password
    		)
  		end
  		user
	end
	###

end
