=begin
File: user.rb
Purpose: Class that validates new User.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class User < ActiveRecord::Base

  has_secure_password
  validates :login, length: { maximum: 50, minimum: 5 }, 
	                uniqueness: { case_sensitive: false }, allow_blank: false
  validates :password, length: { minimum: 8 }, allow_blank: false

  def User.new_remember_token()

  	SecureRandom.urlsafe_base64

  end
  	
  def User.digest( token )

    Digest::SHA1.hexdigest( token.to_s )
  
  end

end