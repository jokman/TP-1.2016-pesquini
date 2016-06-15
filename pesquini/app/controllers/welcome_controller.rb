=begin
File: welcome_controller.rb
Purpose: Class that manipulates the page search of enterprises.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class WelcomeController < ApplicationController

=begin
Method index, only for show
Don't return nothing, because this method is void.
=end

  def index()

		unless params[:q].nil?()
    	raise "params should not be nil" if params[:q] != nil
      params_search[:q][:cnpj_eq] = params[:q][:corporate_name_cont]
    end

		@search = searching_enterprise(params)
    @enterprises = search_result(@search)

  end

#Method that do a search in Enterprise based on params

	def searching_enterprise(params_search)

			search = Enterprise.search(params_search[:q].try(:merge, m: 'or'))

			return search

	end

#Method that saves the search result

	def search_result(search)

		enterprises = search.result()

		return enterprises

	end

end
