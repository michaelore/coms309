class RoutesController < ApplicationController
  include ApplicationHelper
  def create
    @route = Route.new(params[:route])
    respond_to do |format|
      if @route.save
        format.html { redirect_to(@route, :notice => 'Route was successfully created.') }
        format.json { head :created, :location => @route }
      else
        format.html { redirect_to(@route, :action => 'new', :notice => 'Route could not be created.') }
        format.json { render :json => @route.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @route = Route.find(params[:id])
    @route.destroy

    respond_to do |format|
      format.html { redirect_to(:action => 'index', :notice => 'Route was deleted successfully.') }
      format.json { head :ok }
    end
  end

  def update
    @route = Route.find(params[:id])
    respond_to do |format|
      if @route.save
        format.html { redirect_to(@route, :notice => 'Route was successfully updated.') }
        format.json { head :ok }
      else
        format.html { redirect_to(@route, :action => 'edit', :notice => 'Route could not be created.') }
        format.json { render :json => @route.errors, :status => :unprocessable_entity }
      end
    end
  end

  def index
    @routes = Route.find(:all)
    respond_to do |format|
      format.html
      format.json { render :json => @routes }
    end
  end

  def show
    @route = Route.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @route.info(session[:user_id]) }
    end
  end

  def new
    @route = Route.new
  end

  def edit
    @route = Route.find(params[:id])
  end

  def search
    @routes = Route.joins('INNER JOIN locations AS s ON routes.start_id = s.id
                           INNER JOIN locations AS e ON routes.ending_id = e.id').where('s.name ~* ? AND e.name ~* ?', params[:start], params[:ending])
    @routes = Route.find(sortRoutes(@routes))
    respond_to do |format|
      format.html
      format.json { render :json => @routes.map {|r| r.deep} }
    end
  end

  def coordinates
    @route = Route.find(params[:id])
    respond_to do |format|
      format.json { render :json => @route.coordinates }
    end
  end

  def like
    rating = Rating.find_or_create_by_route_and_user(params[:id], session[:user_id])
    rating.like = 1
    rating.save
    head :ok
  end

  def dislike
    rating = Rating.find_or_create_by_route_and_user(params[:id], session[:user_id])
    rating.like = -1
    rating.save
    head :ok
  end

  def favorite
    rating = Rating.find_or_create_by_route_and_user(params[:id], session[:user_id])
    rating.favorite = 1
    rating.save
    head :ok
  end
end
