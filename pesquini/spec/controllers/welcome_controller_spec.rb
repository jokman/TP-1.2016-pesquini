=begin
File: welcome_controller_spec.rb
Purpose: Contains a unit test from class WelcomController.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

require "rails_helper"

RSpec.describe WelcomeController, :type => :controller do 
  
  describe "GET" do 
  
    describe "#index" do
  
      it "should work" do 
        get :index
        expect( response ).to have_http_status( :success )
      end
  
    end
  
  end

end
