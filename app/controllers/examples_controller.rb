class ExamplesController < ApplicationController
  before_filter :require_user, :only => [:new, :edit, :update]

  def index
    @examples = Example.all
    if params[:configuration_id]
      @configuration = Configuration.find(params[:configuration_id])
    end
  end

  def new
    @example = Example.new
  end

  def create
    @example = Example.new(params[:example])

    if @example.save
      flash[:notice] = "New Example created!"
      redirect_back_or_default examples_url
    else
      render :action => :new
    end
  end

  def show
    @example = Example.find_by_id(params[:id]) # find by id so error is not thrown
    
    if @example
      if params[:configuration_id]
        @configuration = Configuration.find(params[:configuration_id])
        @configuration.update_attribute :current_example_id, @example.id
        @test = Test.find_or_create_by_configuration_id_and_example_id_and_user_id(:configuration_id => @configuration.id, :example_id => @example.id, :user_id => @configuration.user.id)
      end
      
      respond_to do |format|
        format.html
        format.pjs  { render :text => @example.source }
      end
    elsif params[:id] and params[:configuration_id]
      Configuration.find(params[:configuration_id]).update_attribute :is_complete, true
      flash[:notice] = "Test configuration complete!"
      redirect_to account_url
    end
  end

  def edit
    @example = Example.find(params[:id])
  end

  def update
    @example = Example.find(params[:id])
    if @example.update_attributes(params[:example])
      flash[:notice] = "Example updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
