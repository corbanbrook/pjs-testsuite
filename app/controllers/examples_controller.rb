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
      redirect_to new_example_url
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
        
        @test = flash[:test] || Test.find_or_create_by_configuration_id_and_example_id_and_user_id(:configuration_id => @configuration.id, :example_id => @example.id, :user_id => @configuration.user.id)
      end
      
      respond_to do |format|
        format.html
        format.pjs  { render :text => @example.source.gsub(/\r\n?/, "\n") }
      end
    elsif params[:id] and params[:configuration_id] # couldnt find a test so we hit the last one, needs to be a better way of doing this.
      Configuration.find(params[:configuration_id]).update_attribute :is_complete, true
      flash[:notice] = "Test configuration complete!"
      redirect_to configuration_examples_url(params[:configuration_id])
    end
  end

  def edit
    @example = Example.find(params[:id])
  end

  def update
    @example = Example.find(params[:id])
    if @example.update_attributes(params[:example])
      flash[:notice] = "Example updated!"
      redirect_to examples_url
    else
      render :action => :edit
    end
  end
end
