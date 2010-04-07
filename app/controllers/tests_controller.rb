class TestsController < ApplicationController
  def update
    @test = Test.find(params[:id])
    
    if params.include? :pass
      @test.pass = true
    elsif params.include? :fail
      @test.pass = false
    end
    
    @test.is_complete = true unless params.include? :skip
      
    @test.user_agent = request.env["HTTP_USER_AGENT"]
    if @test.update_attributes(params[:test])
      redirect_to configuration_example_url(@test.configuration_id, @test.example_id + 1)
    else
      flash[:test] = @test
      redirect_to configuration_example_url(@test.configuration_id, @test.example_id) # stay at the current page 
    end
    
    respond_to do |format|
      format.js {}
    end
  end
  
  def fails
    @fails = []
    
    if params[:platform_id] and params[:browser_id] and params[:version]
      release = Release.find_by_version(params[:version])
       Configuration.find_all_by_platform_id_and_browser_id_and_release_id(params[:platform_id], params[:browser_id], release.id).each do |c|
         @fails.concat(c.tests.failed) if c.tests
       end    
    elsif params[:platform_id]
       Configuration.find_all_by_platform_id(params[:platform_id]).each do |c|
         @fails.concat(c.tests.failed) if c.tests
       end
    elsif params[:browser_id]
      Configuration.find_all_by_browser_id(params[:browser_id]).each do |c|
        @fails.concat(c.tests.failed) if c.tests
      end
    elsif params[:version]
      release = Release.find_by_version(params[:version])
      Configuration.find_all_by_release_id(release.id).each do |c|
        @fails.concat(c.tests.failed) if c.tests
      end
    else
      @fails = Test.failed
    end
  end
end
