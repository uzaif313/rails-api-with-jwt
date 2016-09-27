class Api::V1::BaseController < ApplicationController
  respond_to :json
	def generate_jwt_token(email)
		AuthToken.encode({email:email,time:Time.now})
	end

	def authenticate_user_with_token!
		if check && user = User.find_by(email:check['email'])
			@current_user = user
		else 
			return error_log({"authentication faild":"unable to access this section"})
		end	
	end

	 def check
    auth_header = request.headers['Authorization'] and
      token = auth_header.split(' ').last and
      ::AuthToken.decode(token)[0]
  end

	def error_log(payload = { errors: { unauthorized: ["You are not authorized perform this action."] } })
    render json: payload.merge(response: { code: 401 })
  end
  
  def log_msg(error)
  	render json:{error:error}
  end

end
