# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'
gem 'importmap-rails'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.3'
gem 'sprockets-rails'
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

group :development, :test do
  gem 'brakeman'
  gem 'byebug', platforms: %i[mri windows]
  gem 'capybara_active_admin'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'annotate'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
end

gem 'bundle-audit'

gem 'rubocop', '~> 1.64'

gem 'devise'

gem 'cancancan'

gem 'activeadmin'

gem 'sassc-rails', '~> 2.1'

gem 'haml'
