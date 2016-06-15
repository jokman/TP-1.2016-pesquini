=begin
File: parser_controller.rb
Purpose: Class that manipulate the data to the application.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class Parser::ParserController < ApplicationController

  require 'csv'
  include CheckAndSave

  # Authorize filter only with that caracteristics checked.
  before_filter :authorize, only: [:check_nil_ascii, :check_date, :import, 
                                       :build_state, :build_sanction_type, 
                                       :build_enterprise, :build_sanction, 
                                       :check_and_save]

  # 
  # Empty method.
  # 
  # @return 
  def index()

  end

  # 
  # Method that check's for empty ascii caracters in data file.
  # @param text [String] Keeps the string with the upcase form. 
  # 
  # @return [String] Text in upcase form.
  def check_nil_ascii( text )

    Preconditions.check_argument( text ) { is_not_nil }

    if text.include?( "\u0000" )
      text_format = "Não Informado"
    else
      text_format = text.upcase()
    end

    return text_format

  end

  # 
  # Method that check's data date.
  # @param text [String] receives date from parser.
  # 
  # @return [String] text in date format.
  def check_date( text )

    Preconditions.check_argument( text ) { is_not_nil }

    begin
      text_date = text.to_date()
    rescue
      text_date = nil
    end

    return text_date

  end

  
