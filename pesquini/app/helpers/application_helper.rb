=begin
File: application_helper_spec.rb
Purpose: Informs the alerts.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

module ApplicationHelper
	
	def flash_class( level )
	
		Preconditions.check_not_nil( level )
		case level
		  when :notice  then "alert alert-info"
		  when :success then "alert alert-success"
		  when :error   then "alert alert-error"
		  when :alert   then "alert alert-error"
		  else "invalid error"
		end
	
	end

end