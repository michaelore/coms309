class CoordinatesController < ApplicationController
  def create
    @coordinate = Coordinate.new(params[:post])
    respond_to do |format|
      if @coordinate.save
        format.json { head :created, :location => @coordinate }
      else
        format.json { render :json => @coordinate.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @coordinate = Coordinate.find(params[:id])
    @coordinate.destroy

    respond_to do |format|
      format.json { head :ok }
    end
  end

  def index
    @coordinates = Coordinate.find(:all)
    respond_to do |format|
      format.html
      format.json { render :json => @coordinates }
    end
  end

  def show
    @coordinates = Coordinate.find(params[:id])
    respond_to do |format|
      format.json { render :json => @coordinate }
    end
  end

end
