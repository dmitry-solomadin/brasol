# Configure Spree Preferences
# 
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do: 
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  # config.site_name = "Spree Demo Site"
end

Spree.user_class = "Spree::User"
Spree::Config.set(:allow_ssl_in_production => false)

if Rails.env.production?
  Spree::Config.set(:attachment_path => '/data/brasol/public/spree/products/:id/:style/:basename.:extension')
else
  Spree::Config.set(:attachment_path => ':rails_root/public/spree/products/:id/:style/:basename.:extension')
end
