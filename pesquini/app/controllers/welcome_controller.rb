=begin
File: welcome_controller.rb
Purpose: Class that manipulates the page search of enterprises.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class WelcomeController < ApplicationController
	
	# 
	# Method that gives the result from the search for enterprises in the welcome page.
	# 
	# @return [String] search result with enterprises.
  def index()

    unless params[:q].nil?()
      params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]
    end 

    # [String] Recives the search made.
    @search = Enterprise.search( params[:q].try( :merge, m: 'or' ) )

    # [String] Keeps the result of the search.
    @enterprises = @search.result()

    return @enterprises

  end

end
