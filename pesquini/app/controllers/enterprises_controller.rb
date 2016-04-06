=begin
File: enterprise_controller.rb
Purpose: Class that manipulates enterprises data.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class EnterprisesController < ApplicationController

  def index()

    if params[:q].nil?()
      @search = Enterprise.search( params[:q].try( :merge, m: 'or' ) )
      @enterprises = Enterprise.paginate( :page => params[:page], :per_page => 10 )
    else
      params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]
      @search = Enterprise.search( params[:q].try( :merge, m: 'or' ) )
      @enterprises = @search.result.paginate( :page => params[:page], :per_page => 10 )
    end

  end

  def show()

    @per_page = 10
    @page_num = params[:page].to_i > 0 ? params[:page].to_i  - 1 : 0
    @enterprise = Enterprise.find( params[:id] )
    @collection = Sanction.where( enterprise_id: @enterprise.id )
    @payments = Payment.where( enterprise_id: @enterprise.id ).
                               paginate( :page => params[:page], :per_page => @per_page )
    @sanctions = @collection.paginate( :page => params[:page], :per_page => @per_page )
    @payment_position = enterprise_payment_position( @enterprise )
    @position = Enterprise.enterprise_position( @enterprise )

  end

  def enterprise_payment_position( enterprise )

    p = Enterprise.featured_payments 
    p.each_with_index do |a, index|
      if a.payments_sum == enterprise.payments_sum
        return index + 1 
      else
        
      end
    end

  end

end
