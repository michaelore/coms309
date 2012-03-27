class ContentController < ApplicationController
  def login
    render :file => 'content/mobilelogin'
  end

  def home
    render :file => 'content/mobilehome'
  end

  def search
    render :file => 'content/mobilesearch'
  end

  def history
    render :file => 'content/mobilehistory'
  end

  def map
    render :file => 'content/mobilemap'
  end
end
