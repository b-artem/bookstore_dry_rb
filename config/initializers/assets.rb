# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile +=
  %w[
    books/read_more.js
    line_items/decrement_quantity.js
    line_items/increment_quantity.js
    line_items/update_quantity
    orders/checkouts/use_billing_address.js
    orders/orders/filter.js
    reviews/raty
    settings/remove_account.js
    books/filter.js
  ]
