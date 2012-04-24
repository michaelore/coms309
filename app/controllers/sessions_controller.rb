class SessionsController < ApplicationController
	include ApplicationHelper

	def new
		if isMobile
			render :file => 'sessions/mobilelogin', :layout => 'mobile'
		else
			render :file => 'sessions/login', :layout => 'desktoplogin'
		end
	end
	
	def create
		if params[:commit] == "login"
			user = User.find_by_email(params[:user][:email])
			if user && user.authenticate(params[:user][:password])
				session[:user_id] = user.id
				redirect_to "/home"
			else
				flash.alert = "Invalid email or password"
				redirect_to "/login"
			end
		elsif params[:commit] == "register"
			user = User.new(params[:user])
			if user.save
				session[:user_id] = user.id
				redirect_to "/home"
			else
				flash.alert = "Your account could not be created"
				redirect_to "/login"
			end
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to "/login"
	end
end
