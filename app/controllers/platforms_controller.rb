class PlatformsController < ApplicationController
  before_filter :require_user, :only => [:new, :edit, :update]

  def new
    @platform = Platform.new
  end

  def create
    @platform = Platform.new(params[:platform])
    if @platform.save
      flash[:notice] = "New platform created!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def show
    @platform = Platform.find(params[:id])
  end
end
