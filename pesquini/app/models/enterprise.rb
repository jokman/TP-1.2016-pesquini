=begin
File: enterprise.rb
Purpose: Class that validate the field CNPJ, and register an enterprise.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class Enterprise < ActiveRecord::Base

  has_many :sanctions
  has_many :payments
  validates_uniqueness_of :cnpj

  scope :featured_sanctions, -> ( number = nil ){number ? order( "sanctions_count DESC" )
                                              .limit( number ) :order('sanctions_count DESC') }
  scope :featured_payments, -> ( number = nil ){number ? order( "payments_sum DESC" )
                                              .limit( number ) :order( "payments_sum DESC" ) }

   def last_sanction()
    
    sanction = self.sanctions.last
    
    unless sanction.nil?()    
      self.sanctions.each do |s|
        Preconditions.check_not_nil( s )
        if s.initial_date > sanction.initial_date
          sanction = s 
        else

        end
      end
    end
    
    sanction
  
  end

  def last_payment()
  
    payment = self.payments.last()
  
    unless payment.nil?()
      self.payments.each do |f|
         Preconditions.check_not_nil( f )
        if f.sign_date > payment.sign_date
          payment = f 
        else

        end
      end
    end
  
    payment
  
  end

  def payment_after_sanction?()
  
    sanction = last_sanction
    payment = last_payment
  
    if sanction && payment
      payment.sign_date < sanction.initial_date
    else
      false
    end
  
  end

  def refresh!()
  
    Preconditions.check_not_nil( cnpj )
    e = Enterprise.find_by_cnpj( self.cnpj )
  
  end

  def self.enterprise_position( enterprise )

    Preconditions.check_not_nil( enterprise )

    orderedSanc = self.featured_sanctions
    groupedSanc = orderedSanc.uniq.group_by( &:sanctions_count ).to_a

    groupedSanc.each_with_index do |k, index|
      Preconditions.check_not_nil( k )
      if k[0] == enterprise.sanctions_count
        return index + 1
      else

      end
    end

  end

  def self.most_sanctioned_ranking()

    enterprise_group = []
    enterprise_group_count = []
    @enterprise_group_array = []

    Preconditions.check_not_nil( x )
    a = Enterprise.all.sort_by{ |x| x.sanctions_count }
    b = a.uniq.group_by( &:sanctions_count ).to_a.reverse

    b.each do |k|
      Preconditions.check_not_nil( k )
      enterprise_group << k[0]
      enterprise_group_count << k[1].count
    end
 
    @enterprise_group_array << enterprise_group
    @enterprise_group_array << enterprise_group_count
    @enterprise_group_array
  
  end

end