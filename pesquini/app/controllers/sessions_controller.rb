=begin
File: session_controller.rb
Purpose: Class that permit login and logout the system.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class SessionsController < ApplicationController

  #
  # Empty method.
  #
  # @return
  def new()

  end

  #
  # Method that create a session.
  #
  # @return logged status.
  def create()

    # [String] Receive the parameters to login.
    login = params[:session][:login].downcase
    password = params[:session][:password]

    # [String] Keep the logged user.
    user = User.find_by(login: login)

    # Sign in user by login and password.
    if user && user.authenticate(password)
      sign_in user
      redirect_to root_path
    else
      flash[:error] = "Login ou senha invalidos!"
      render :new
    end

  end

  #
  # Method that destroy the session.
  #
  # @return loggout status.
  def destroy()

    if signed_in?
      sign_out
      redirect_to root_path
    # else case: do nothing.
    end

  end

end
