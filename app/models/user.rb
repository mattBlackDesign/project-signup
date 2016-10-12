class User < ActiveRecord::Base
	has_and_belongs_to_many :homes

	def self.from_omniauth(auth)
		where(auth.slice(provider: auth.provider, uid: auth.uid)).first_or_initialize.tap do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.email = auth.email
			user.name = auth.info.name
			user.image = auth.info.image
			user.oauth_token = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.save!
		end
	end
end
