if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'bootstrap-sass'

gem 'delayed_job_active_record'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem "hirb"
  gem 'capistrano'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :production do
  gem 'unicorn'
  gem 'mysql2'
  gem 'foreman'
  gem 'therubyracer' #only required for 0.70.x or later
  gem "daemons" # required for delayed_job
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
gem 'spree', '1.3.2'
gem 'spree_usa_epay'
gem 'spree_skrill'
gem 'spree_i18n', :git => 'git://github.com/spree/spree_i18n.git', :branch => '1-3-stable'
gem 'spree_auth_devise', :git => 'git://github.com/spree/spree_auth_devise', :branch => '1-3-stable'
gem "spree_product_zoom", :git => "git://github.com/spree/spree_product_zoom.git", :branch => '1-3-stable'
gem 'spree_static_content', :git => 'git://github.com/spree/spree_static_content.git', :branch => '1-3-stable'
