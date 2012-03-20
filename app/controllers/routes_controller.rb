class RoutesController < ApplicationController
  def create
    @route = Route.new(params[:post])
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
      format.json { render :json => @route }
    end
  end

  def new
    @route = Route.new
  end

  def edit
    @route = Route.find(params[:id])
  end
end
