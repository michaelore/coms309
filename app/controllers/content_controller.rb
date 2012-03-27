class ContentController < ApplicationController
  def login
    render :file => 'content/mobilelogin'
  end

  def home
    redirect_to :action => 'login' unless session[:logged_in]
    render :file => 'content/mobilehome'
  end

  def search
    redirect_to :action => 'login' unless session[:logged_in]
    render :file => 'content/mobilesearch'
  end

  def history
    redirect_to :action => 'login' unless session[:logged_in]
    render :file => 'content/mobilehistory'
  end

  def map
    redirect_to :action => 'login' unless session[:logged_in]
    render :file => 'content/mobilemap'
  end
end
