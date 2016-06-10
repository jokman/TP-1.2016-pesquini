=begin
File: application_controller.rb
Purpose: Raise an exception in case the application doesn't start right.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

class ApplicationController < ActionController::Base

  include SessionsHelper

=begin
  Prevent CSRF attacks by raising an exception.
  For APIs, you may want to use :null_session instead.
=end
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  rescue_from ActionController::RoutingError, :with => :render_not_found


end
