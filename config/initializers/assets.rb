# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( principal.scss )
Rails.application.config.assets.precompile += %w( sidebar.scss )
Rails.application.config.assets.precompile += %w( principal_login.scss )
Rails.application.config.assets.precompile += %w( sidebar_login.scss )
Rails.application.config.assets.precompile += %w( search.scss )
Rails.application.config.assets.precompile += %w( peliculas.scss )
Rails.application.config.assets.precompile += %w( modal_pelicula.scss )
Rails.application.config.assets.precompile += %w( estanteria.scss )
Rails.application.config.assets.precompile += %w( search.js )