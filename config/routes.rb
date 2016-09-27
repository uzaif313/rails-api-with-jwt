Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
    	resources :articles
    end
  end


	# namespace :api do
	# 	namespace :v1 do
		 # devise_for :users,controllers:{registrations:'registrations',sessions:'sessions'}
		# end
  #  end
	devise_for :users,controllers:{registrations:'api/v1/registrations',sessions:'api/v1/sessions'}
end
