class RoutesController < ApplicationController
  include ApplicationHelper
  def create
    vertices = []
    for i in 1..(params[:route][:lat].length-1)
      coord = Coordinate.new(:latitude => params[:route][:lat][i], :longitude => params[:route][:lon][i])
      coord.save
      vertices.push(coord.id)
    end
    @route = Route.new(:start_id => params[:route][:start_id], :ending_id => params[:route][:ending_id], :time => params[:route][:time], :vertices => vertices)
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
    @userid = session[:user_id]
    @routes = Route.joins('INNER JOIN locations AS s ON routes.start_id = s.id
                           INNER JOIN locations AS e ON routes.ending_id = e.id').where('s.name ~* ? AND e.name ~* ?', params[:start], params[:ending])
    @routes = Route.find(sortRoutes(@routes))
    respond_to do |format|
      format.html
      format.json { render :json => @routes.map {|r| r.info(session[:user_id])} }
    end
  end

  def history
    @userid = session[:user_id]
    @routes = User.find(session[:user_id]).affiliatees
    respond_to do |format|
      format.html { render :file => "routes/mobilehistory", :layout => "mobile" }
      format.json { render :json => @routes.map {|r| r.info(session[:user_id])} }
    end
  end

  def coordinates
    @route = Route.find(params[:id])
    respond_to do |format|
      format.json { render :json => @route.coordinates }
    end
  end

  def like
    if (session[:user_id])
      rating = Rating.find_or_create_by_route_id_and_user_id(params[:id], session[:user_id])
      if rating.like == 1
        rating.like = 0
      else
        rating.like = 1
      end
      rating.save
      render :json => Route.find(params[:id]).info(session[:user_id])
    else
      render :json => "wtf log in dude"
    end
  end

  def dislike
    if (session[:user_id])
      rating = Rating.find_or_create_by_route_id_and_user_id(params[:id], session[:user_id])
      if rating.like == -1
        rating.like = 0
      else
        rating.like = -1
      end
      rating.save
      render :json => Route.find(params[:id]).info(session[:user_id])
    else
      render :json => "wtf log in dude"
    end
  end

  def favorite
    if (session[:user_id])
      rating = Rating.find_or_create_by_route_id_and_user_id(params[:id], session[:user_id])
      if rating.favorite == 1
        rating.favorite = 0
      else
        rating.favorite = 1
      end
      rating.save
      render :json => Route.find(params[:id]).info(session[:user_id])
    else
      render :json => "wtf log in dude"
    end
  end
end
