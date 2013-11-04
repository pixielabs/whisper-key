source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'pg'
gem 'jbuilder', '~> 1.2'
gem 'unicorn'
gem 'haml-rails'
gem 'yappconfig'
gem 'kramdown'
gem 'kaminari'

# Assets
gem 'jquery-rails'
gem 'bootstrap-sass', '3.0.0.0rc'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'font-awesome-rails', '~> 4.0.1.0'
gem 'bourbon'

group :production do
  # Heroku support
  gem 'rails_12factor'

  gem 'exception_notification'
  gem 'aws-sdk'
end

# Testing
group :test, :development do
  gem 'rspec-rails'
  gem 'dotenv-rails'
end

group :test do
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'spork-rails', '~> 4.0.0'
end
