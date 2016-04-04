# File: application_helper_spec.rb
# Purpose: Informs the alerts.
# License: GPL v3.
# Pesquini Group 6
# FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.

module ApplicationHelper
  def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
    end
  end
end
