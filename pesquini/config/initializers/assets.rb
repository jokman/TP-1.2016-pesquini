# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( application.js )
Rails.application.config.assets.precompile += %w( dinamic_selection.js )
Rails.application.config.assets.precompile += %w( enterprises.js )
Rails.application.config.assets.precompile += %w( nav_bar_transparency.js )
Rails.application.config.assets.precompile += %w( smooth_scrolling.js )
Rails.application.config.assets.precompile += %w( highcharts-custom.js )
Rails.application.config.assets.precompile += %w(pagination.js)
Rails.application.config.assets.precompile += %w( search.js )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
