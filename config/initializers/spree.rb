# Configure Spree Preferences
# 
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do: 
# config.setting_name = 'new value'
require 'spree/product_filters'

Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  # config.site_name = "Spree Demo Site"
end

Spree.user_class = "Spree::User"
Spree::Config.set(:allow_ssl_in_production => false)
Spree::Config.set(:allow_guest_checkout => false)
Spree::Config.set(:address_requires_state => false)
Spree::Config.set(:admin_products_per_page => 20)
Spree::Config.set(:products_per_page => 20)
Spree::Auth::Config[:registration_step] = false

if Rails.env.production?
  Spree::Config.set(:attachment_path => '/data/brasol/public/spree/products/:id/:style/:basename.:extension')
else
  Spree::Config.set(:attachment_path => ':rails_root/public/spree/products/:id/:style/:basename.:extension')
end
