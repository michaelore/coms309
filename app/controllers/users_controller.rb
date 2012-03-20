class UsersController < ApplicationController
  def create
    @user = User.new(params[:post])
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.json { head :created, :user => @user }
      else
        format.html { redirect_to(@user, :action => 'new', :notice => 'User could not be created.') }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(:action => 'index', :notice => 'User was deleted successfully.') }
      format.json { head :ok }
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.json { head :ok }
      else
        format.html { redirect_to(@user, :action => 'edit', :notice => 'User could not be created.') }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def index
    @users = User.find(:all)
    respond_to do |format|
      format.html
      format.json { render :json => @users }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end

  def new
	@user = User.new
  end

  def edit
	@user = User.find(params[:id])
  end
end
