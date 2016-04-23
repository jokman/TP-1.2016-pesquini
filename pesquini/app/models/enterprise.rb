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
      self.sanctions.each do |searched_sanction|
        Preconditions.check_not_nil( searched_sanction )
        if searched_sanction.initial_date > sanction.initial_date
          sanction = searched_sanction
        else
          # Nothing to do.
        end
      end
    end

    sanction

  end

  def last_payment()

    payment = self.payments.last()

    unless payment.nil?()
      self.payments.each do |searched_payment|
         Preconditions.check_not_nil( searched_payment )
        if searched_payment.sign_date > payment.sign_date
          payment = searched_payment
        else
          # Nothing to do.
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
    new_enterprise = Enterprise.find_by_cnpj( self.cnpj )

  end

  def self.enterprise_position( enterprise )

    Preconditions.check_not_nil( enterprise )

    orderedSanc = self.featured_sanctions
    groupedSanc = orderedSanc.uniq.group_by( &:sanctions_count ).to_a

    groupedSanc.each_with_index do |qnt_sanctions, index|
      Preconditions.check_not_nil( qnt_sanctions )
      if qnt_sanctions[0] == enterprise.sanctions_count
        return index + 1
      else
        # Nothing to do.
      end
    end

  end

  def self.most_sanctioned_ranking()

    assert enterprise_group.empty?, "The list must not be empty!"
    assert enterprise_group_count.empty?, "The list must not be empty!"
    assert enterprise_group_array.empty?, "Array must not be empty!"
    
    enterprise_group = []
    enterprise_group_count = []
    @enterprise_group_array = []

    
    sorted_sanctions = Enterprise.all.sort_by{ |qnt_sanctions_ranking| qnt_sanctions_ranking.sanctions_count }
    sorted_group_sanctions = sorted_sanctions.uniq.group_by( &:sanctions_count ).to_a.reverse

    sorted_group_sanctions.each do |qnt_group_sanctions|
      enterprise_group << qnt_group_sanctions[0]
      enterprise_group_count << qnt_group_sanctions[1].count
    end

    @enterprise_group_array << enterprise_group
    @enterprise_group_array << enterprise_group_count
    @enterprise_group_array

  end

end