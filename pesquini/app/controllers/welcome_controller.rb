# File: welcome_controller.rb
# Purpose: Contains search method
# License: GPL v3.
# Pesquini Group 6
# FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.

class WelcomeController < ApplicationController
  def index
    params[:q][:cnpj_eq] = params[:q][:corporate_name_cont] unless params[:q].nil?
    @search = Enterprise.search(params[:q].try(:merge, m: 'or'))
    @enterprises = @search.result
  end
end
