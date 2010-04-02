class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
    
    @example_count = Example.count;
    @detected_configuration = Configuration.new 
    
    Browser.all.each do |browser|
      if request.env["HTTP_USER_AGENT"].match(browser.name)
        @detected_configuration.browser = browser
        break
      end
    end
    
    Platform.all.each do |platform|
      if request.env["HTTP_USER_AGENT"].match(platform.regexp)
        @detected_configuration.platform = platform
        break
      end
    end
    
    @user_agent = request.env["HTTP_USER_AGENT"]
    
    # Search through configurations
    @found_new_configuration = true
    
    if @detected_configuration.platform
      @user.configurations.each do |configuration|
        if @detected_configuration.platform.name_and_version == configuration.platform.name_and_version and @detected_configuration.browser.name == configuration.browser.name
          @found_new_configuration = false
          break
        end
      end
    end
  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
