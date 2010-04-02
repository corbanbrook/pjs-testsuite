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
    end
  end
end
