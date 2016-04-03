# File: application_controller.rb
# Purpose: Contains errors methods
# License: GPL v3.
# Pesquini Group
# FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.

class ApplicationController < ActionController::Base
  include SessionsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  rescue_from ActionController::RoutingError, :with => :render_not_found

  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  def render_not_found
    respond_to do |f|
      f.html{ render :template => "errors/404", :status => 404 }
    end
  end
end
