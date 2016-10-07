source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'

gem 'pg', '~> 0.18'
gem 'pg_search', '~> 1.0.6'
gem 'puma', '~> 3.0'
gem 'bcrypt', '~> 3.1.7'

gem 'rack-cors'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-rspec', require: false
end

group :test do
  gem 'json_spec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
