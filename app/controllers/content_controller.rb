class ContentController < ApplicationController
  include ApplicationHelper

  def home
    if isMobile
      render :file => 'content/mobilehome', :layout => 'mobile'
    else
      render :file => 'content/desktopUser', :layout => 'desktop'
    end
  end

  def search
    if isMobile
      render :file => 'content/mobilesearch', :layout => 'mobile'
    else
      render :file => 'content/search', :layout => 'desktop'
    end
  end

  def history
    if isMobile
      render :file => 'content/mobileshistory', :layout => 'mobile'
    else
      render :file => 'content/history', :layout => 'desktop'
    end
  end

  def map
    if isMobile
      render :file => 'content/mobilemap', :layout => 'mobile'
    else
      render :file => 'content/map', :layout => 'desktop'
    end
  end
end
