=begin
File: parser_controller.rb
Purpose: Class that manipulate the data to the application.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class Parser::ParserController < ApplicationController

  require 'csv'
  @@filename = 'parser_data/CEIS.csv'

  before_filter :authorize, only: [:check_nil_ascii, :check_date, :import, 
                                       :build_state, :build_sanction_type, 
                                       :build_enterprise, :build_sanction, 
                                       :check_and_save]

  def index()

  end

  def check_nil_ascii( text )

    if text.include?( "\u0000" )
      return "Não Informado"
    else
      return text.upcase()
    end

  end

  def check_date( text )

    begin
      return text.to_date()
    rescue
      return nil
    end

  end

  def check_and_save( c )

    begin
      c.save!
      c
    rescue ActiveRecord::RecordInvalid
      c = c.refresh!
      c
    end
    
  end

end
