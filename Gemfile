source 'https://rubygems.org'

gem 'bundler'
gem 'rake'
gem 'hanami',       '0.8.0'
gem 'hanami-model', '~> 0.5'

gem 'sass'

# Frame2 embed...
gem "roda", "~> 2.1.0"
gem "bcrypt", "~> 3.1.10"
gem "rack-protection", "~> 1.5.3"
gem "rack_csrf", "~> 2.5.0"
# END...

gem 'pg'

group :test do
  gem 'minitest'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end

group :development do
  gem 'shotgun'
end

group :development, :test do
  gem 'dotenv', '~> 2.0'
end
