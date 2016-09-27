if @user.errors.present?
	json.erros @user.errors.messages
	json.response do
		json.code 422
	end
else
	json.user do
		json.email @user.email
		json.token @token
	end
	json.response do
		json.code 201
	end
end