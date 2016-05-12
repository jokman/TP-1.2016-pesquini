=begin
File: welcome_controller_spec.rb.
Purpose: Class that does a unit test of parser_controller.
License: GPL v3.
Pesquini Group 6.
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

require "rails_helper"

RSpec.describe SessionsController, :type => :controller do 
	
  describe   "GET" do 
	
	  describe '#new' do
	
	    it "should work" do 
		    get :new
				expect(response).to have_http_status(:success)
		  end
	
	  end
	
	end

end
