=begin
File: payment.rb
Purpose: Class with information on payments.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class Payment < ActiveRecord::Base

  belongs_to :enterprise

  validates_uniqueness_of :process_number

  def refresh!()

    p = Payment.find_by_process_number( self.process_number )

  end

end