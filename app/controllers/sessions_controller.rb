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
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to "/home"
		else
			flash.now.alert = "Invalid email or password"
			render "new"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to "/home"
	end
end
