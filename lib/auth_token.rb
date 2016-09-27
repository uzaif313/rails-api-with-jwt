 require 'jwt'
class AuthToken
	
	# Encode json web token here based on given payload
	def self.encode(payload)
		payload = payload.dup
		payload['exp'] = 2.minutes.from_now.to_i
		JWT.encode(payload,"whatissecratcode")
	end

	# decode json web token here based on given token
	def self.decode(token)
		JWT.decode(token,"whatissecratcode")
	end

end