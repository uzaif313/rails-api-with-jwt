class Api::V1::RegistrationsController < Api::V1::BaseController
	
	def create
		@user = User.new(user_params)
		# Generate Token based on user email and registration time
		@token = generate_jwt_token(@user) if @user.save
		
	end

	def user_params
		params.require(:user).permit(:email,:password)
	end
end
