class ContentController < ApplicationController
  include ApplicationHelper

  def home
    if isMobile
      render :file => 'content/mobilehome'
    else
      render :file => 'content/home'
    end
  end

  def search
    if isMobile
      render :file => 'content/mobilesearch'
    else
      render :file => 'content/search'
    end
  end

  def history
    if isMobile
      render :file => 'content/mobileshistory'
    else
      render :file => 'content/history'
    end
  end

  def map
    if isMobile
      render :file => 'content/mobilemap'
    else
      render :file => 'content/map'
    end
  end
end
