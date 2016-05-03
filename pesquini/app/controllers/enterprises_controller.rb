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

  #
  # Method to show enterprises attributes.
  #
  # @return
  def show()

    @per_page = 10
    @page_num = show_page_num()
    @enterprise = Enterprise.find( params[:id] )
    @collection = Sanction.where( enterprise_id: @enterprise.id )
    @payments = Payment.where( enterprise_id: @enterprise.id ).
                               paginate( :page => params[:page], :per_page => @per_page )
    @sanctions = @collection.paginate( :page => params[:page], :per_page => @per_page )
    @payment_position = enterprise_payment_position( @enterprise )
    @position = Enterprise.enterprise_position( @enterprise )

  end

  #
  # Method to show the page number.
  #
  # @return page_num
  def show_page_num()

    if params[:page].to_i > 0
      @page_num = params[:page].to_i  - 1
    else
      @page_num = 0
    end

  end

  #
  # Method that manipulates the payments to the enterprise.
  #
  # @return position of most payment enterprises.
  def enterprise_payment_position( enterprise )

    payment_position = Enterprise.featured_payments

    payment_position.each_with_index do |total_sum, index|

      Preconditions.check_not_nil( total_sum )
      Preconditions.check( index ) { index >= 0 }
      if total_sum.payments_sum == enterprise.payments_sum
        return index + 1
      else
        # Nothing to do.
      end
    end

  end

end
