=begin
File: parser_cei_controller.rb
Purpose: Class that treats the parser data from file CEIS.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class Parser::ParserCeiController < Parser::ParserController

  require 'csv'
  @@filename = 'parser_data/CEIS.csv' # Keeps the .csv file.

  before_filter :authorize, only: [:check_nil_ascii, :check_date, :import, 
                                       :build_state, :build_sanction_type, 
                                       :build_enterprise, :build_sanction, 
                                       :check_and_save]

  # Empty method.
  def index()

  end

  # Method that check's for empty ascii caracters in data file.
  def check_nil_ascii( text )

    Preconditions.check_argument( text ) { is_not_nil }
    if text.include?( "\u0000" )
      return "Não Informado"
    else
      return text.upcase()
    end

  end

  # Method that check's the sanction date.
  def check_date( text )

    Preconditions.check_argument( text ) { is_not_nil }
    begin
      return text.to_date()
    rescue
      return nil
    end

  end

  # Method that import the .csv file with the data.
  def import()

    xd = 0
    CSV.foreach( @@filename, :headers => true, :col_sep => "\t",
                 :encoding => 'ISO-8859-1' ) do |row|
      data = row.to_hash
      unless data["Tipo de Pessoa"].match( "J|j" ).nil?()
        sanction_type = build_sanction_type( data )       # Keeps the sanction type data.
        state = build_state( data )                       # Keeps the state data.
        enterprise = build_enterprise( data )             # Keeps the enterprise data.
        build_sanction( data, sanction_type, state, enterprise )
      end
    end

  end
 
  # Method that take and create the state. 
  def build_state( row_data )

    Preconditions.check_argument( row_data ) { is_not_nil }
    new_state = State.new()      # Keeps the new state created.
    new_state.abbreviation = check_nil_ascii( row_data["UF Órgão Sancionador"] )
    check_and_save( new_state )

  end

  # Method that take and create the sanction.
  def build_sanction_type( row_data )

    Preconditions.check_argument( row_data ) { is_not_nil }
    new_sanction_type = SanctionType.new()    # Keeps the new sanction type created.
    new_sanction_type.description = check_nil_ascii( row_data["Tipo Sanção"] )
    check_and_save( new_sanction_type )

  end

  # Method that take and create the the enterprise.
  def build_enterprise( row_data )

    Preconditions.check_argument( row_data ) { is_not_nil }
    e = Enterprise.new()
    e.cnpj = row_data["CPF ou CNPJ do Sancionado"]
    # e.trading_name = check_nil_ascii(row_data["Nome Fantasia - Cadastro Receita"])
    e.corporate_name = check_nil_ascii( row_data["Razão Social - Cadastro Receita"] )
    check_and_save( e )

  end

  # Method that create sanction.
  def build_sanction( row_data, sanction_type, state, enterprise )
    
    Preconditions.check_argument( row_data, sanction_type, state, enterprise ) { is_not_nil }
    s = Sanction.new()
    s.initial_date = check_date( row_data["Data Início Sanção"] )
    s.final_date = check_date( row_data["Data Final Sanção"] )
    s.process_number = check_nil_ascii( row_data["Número do processo"] )
    s.enterprise_id = enterprise.id
    s.sanction_type_id = sanction_type.id
    s.sanction_organ = check_nil_ascii( row_data["Órgão Sancionador"] )
    s.state_id = state.id
    check_and_save( s )

  end

  # Method that check and save the data.
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
