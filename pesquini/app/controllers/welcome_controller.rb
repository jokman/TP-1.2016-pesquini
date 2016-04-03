class WelcomeController < ApplicationController
	
  def index()

    unless params[:q].nil?
      params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]
    end 

    @search = Enterprise.search( params[:q].try( :merge, m: 'or' ) )
    @enterprises = @search.result()

  end
end
