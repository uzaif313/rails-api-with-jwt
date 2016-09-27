class Api::V1::SessionsController < Api::V1::BaseController
	
	def create
		@user = User.find_for_database_authentication(email:user_params[:email])
		return is_empty_params unless @user
		return login_faild unless @user.valid_password?(user_params[:password])
		@token = generate_jwt_token(@user.email)
	end
  
  # check params is empty or not for login
	def is_empty_params
		if user_params[:email].blank? || user_params[:password].blank?
			return error_log errors:{unauthenticated:["Please Provide Proper Parameters"]}
		end
	end

	# user params method
	def user_params
		params.require(:session).permit(:email,:password)
	end

	# login faild case handel here
	def login_faild
		return error_log errors:{unauthenticated:["Incorrect User name and password"]}
	end

	def destroy
      token = AuthToken.decode(request.headers['Authorization'].split(" ").last)
      decode = generate_jwt_token("logout")
    rescue
    	render json:{message:"Logout successfully"}
	end
end
