# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( customer_discovery.js )
Rails.application.config.assets.precompile += %w( customer_discovery.css )
Rails.application.config.assets.precompile += %w( lifecycles.js )
Rails.application.config.assets.precompile += %w( lifecycles.css.scss )
Rails.application.config.assets.precompile += %w( starburst.js )
Rails.application.config.assets.precompile += %w( starburst.css )
