=begin
File: session_controller.rb
Purpose: Class that permit login and logout the system.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class SessionsController < ApplicationController

  def new()

  end

  def create()

    Preconditions.check_not_nil( login )
    Preconditions.check_not_nil( password )
    login = params[:session][:login].downcase
    password = params[:session][:password]
    user = User.find_by( login: login )

    if user && user.authenticate( password )
      sign_in user
      redirect_to root_path
    else
      flash[:error] = "Login ou senha invalidos!"
      render :new
    end

  end

  def destroy()

    assert user.empty?, "User must not be empty!"
    if signed_in?()
      sign_out 
      redirect_to root_path
    else
      # Nothing to do.
    end

  end
  
end
