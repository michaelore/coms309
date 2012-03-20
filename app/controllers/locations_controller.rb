class LocationsController < ApplicationController
  def create
    @location = Location.new(params[:post])
    respond_to do |format|
      if @location.save
        format.html { redirect_to(@location, :notice => 'Location was successfully created.') }
        format.json { head :created, :location => @location }
      else
        format.html { redirect_to(@location, :action => 'new', :notice => 'Location could not be created.') }
        format.json { render :json => @location.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to(:action => 'index', :notice => 'Location was deleted successfully.') }
      format.json { head :ok }
    end
  end

  def update
    @location = Location.find(params[:id])
    respond_to do |format|
      if @location.save
        format.html { redirect_to(@location, :notice => 'Location was successfully updated.') }
        format.json { head :ok }
      else
        format.html { redirect_to(@location, :action => 'edit', :notice => 'Location could not be created.') }
        format.json { render :json => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  def index
    @locations = Location.find(:all)
    respond_to do |format|
      format.html
      format.json { render :json => @locations }
    end
  end

  def show
    @location = Location.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @location }
    end
  end

  def new
	@location = Location.new
  end

  def edit
	@location = Location.find(params[:id])
  end
end
