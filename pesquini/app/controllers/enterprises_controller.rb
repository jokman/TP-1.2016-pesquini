=begin
File: enterprise_controller.rb
Purpose: Class that manipulates enterprises data.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class EnterprisesController < ApplicationController

  # 
  # Give result form enterprise search.
  # 
  # @return [String] enterprises.
  def index()

    if params[:q].nil?()

      Preconditions.check_not_nil( @search )
      Preconditions.check_not_nil( @enterprises )

      # [String] keeps enterprises search.
      @search = Enterprise.search( params[:q].try( :merge, m: 'or' ) )

      # [Integer] keeps number of results per page. 
      @enterprises = Enterprise.paginate( :page => params[:page], :per_page => 10 )
    else
      params[:q][:cnpj_eq] = params[:q][:corporate_name_cont]
      @search = Enterprise.search( params[:q].try( :merge, m: 'or' ) )
      @enterprises = @search.result.paginate( :page => params[:page], :per_page => 10 )
    end

    return @enterprises

  end

  #
  # Method to show enterprises attributes.
  #
  # @return [String] enterprise attributes.
  def show()

    # [Integer] keeps number of enterprises search result per page.
    @per_page = 10

    # [Integer] keeps page page number.
    @page_number = show_page_number()

    # [String] keeps enterprise found by id.
    @enterprise = Enterprise.find( params[:id] )

    # [String] keeps sanction enterprises.
    @collection = Sanction.where( enterprise_id: @enterprise.id )

    # [Double] keeps enterprise paid value.
    @payments = Payment.where( enterprise_id: @enterprise.id ).
                               paginate( :page => params[:page], :per_page => @per_page )

    # [String] keeps sanctions that will be shown by page.
    @sanctions = @collection.paginate( :page => params[:page], :per_page => @per_page )

    # [Integer] keeps enterprise position by payment.
    @payment_position = enterprise_payment_position( @enterprise )

    # [Integer] keeps enterprise position.
    @position = Enterprise.enterprise_position( @enterprise )

    return @position

  end

  #
  # Method to show the page number.
  #
  # @return [ Integer ] page number.
  def show_page_number()

    Preconditions.check( @page_num ) { is_not_nil and has_type( Integer ) 
                                       and satisfies( "> 0" ) { @page_num > 0 } }
    if params[:page].to_i > 0
      @page_number = params[:page].to_i  - 1
    else
      @page_number = 0
    end

    return @page_number

  end

  # 
  # Method that manipulates the payments to the enterprise.
  # @param enterprise [String] keeps enterprises information.
  # 
  # @return [String] position of most payment enterprises.
  def enterprise_payment_position( enterprise )

    # [String] receives enterprises payments.
    payment_position = Enterprise.featured_payments

    payment_position.each_with_index do |total_sum, index|

      Preconditions.check( total_sum ) { is_not_nil and has_type( double ) }
      Preconditions.check( index ) { index >= 0 }
      
      if total_sum.payments_sum == enterprise.payments_sum
        return index + 1
      else
        # Nothing to do.
      end
    end

    return payment_position

  end

end
