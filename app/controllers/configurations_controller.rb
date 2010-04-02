class ConfigurationsController < ApplicationController
  before_filter :require_user, :only => [:new, :edit, :update]

  def new
    @configuration = Configuration.new
  end

  def create
    @configuration = Configuration.new(params[:configuration])
    @configuration.user = current_user
    if @configuration.save
      flash[:notice] = "New Configuration created!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def show
    @configuration = Configuration.find(params[:id])
  end

  def edit
    @configuration = Configuration.find(params[:id])
  end

  def update
    @configuration = Configuration.find(params[:id])
    if @configuration.update_attributes(params[:configuration])
      flash[:notice] = "Configuration updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
