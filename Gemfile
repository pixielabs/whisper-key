source 'https://rubygems.org'
ruby '2.7.8'

gem 'rails', '~> 4.2.11'
gem 'pg', '< 1'
gem 'jbuilder', '~> 1.2'
gem 'passenger'
gem 'haml-rails'
gem 'yappconfig'
gem 'kramdown'
gem 'kaminari'
gem 'spring', group: :development

# Assets
gem 'jquery-rails'
gem 'bootstrap-sass', '3.0.0.0rc'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'font-awesome-rails', '~> 4.0.1.0'
gem 'bourbon', '< 5'

group :production do
  # Heroku support
  gem 'rails_12factor'
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
