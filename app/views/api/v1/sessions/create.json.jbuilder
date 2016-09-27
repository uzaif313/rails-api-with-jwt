json.user do
	json.email @user.email
	json.token @token
end
json.response do
	json.code 200
end
