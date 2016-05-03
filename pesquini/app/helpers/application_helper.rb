=begin
File: application_helper_spec.rb
Purpose: Module with alerts levels.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

module ApplicationHelper
	
	# 
	# Method that informs the alerts.
	# @param level [String] receive the types of alert.
	# 
	# @return [String] level with alert message.
	def flash_class( level )
	
		Preconditions.check_not_nil( level )
		case level
		  when :notice  then "alert alert-info"
		  when :success then "alert alert-success"
		  when :error   then "alert alert-error"
		  when :alert   then "alert alert-error"
		  else "invalid alert"
		end
	
	end

end