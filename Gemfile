source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '~> 5.0.1'

# Database
gem 'pg', '~> 0.19.0'

# App server
gem 'puma', '~> 3.0'

gem 'redis'

# Frontend
gem 'sass-rails', '~> 5.0.3'
gem 'uglifier', '>= 2.5.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails', '~> 4.2.2'
gem 'turbolinks', '~> 5.0.0'
gem 'slim-rails', '~> 3.1.1'
gem 'simple_form', '~> 3.4.0'

# Pagination
gem 'kaminari'

# Worker
gem 'sidekiq', '~> 3.3.4'

# Redactor
gem 'ckeditor_rails', '~> 4.6.2'

# State machines
gem 'aasm'

group :development, :test do
  # Debug
  gem 'jazz_fingers', '~> 4.0.1'

  # Tests
  gem 'rspec-rails'
  gem 'guard-rspec', '~> 4.2.10', require: false

  # Fake data generator
  gem 'faker', '~> 1.6.6'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors', '~>1.1.0'
  gem 'pry'
  gem 'letter_opener', :group => :development
end

group :test do
  gem 'database_cleaner', '~> 1.5.3'
  gem 'factory_girl_rails', '~> 4.7.0'
  gem 'shoulda-matchers', '~> 3.1.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
