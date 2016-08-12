source 'https://rubygems.org'

gem 'bundler'
gem 'rake'
gem 'hanami',       '~> 0.8'
gem 'hanami-model', '~> 0.6'

gem 'sass'

gem 'dataminer', path: '/home/james/ra/dm_tests/dataminer'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/applications/code-reloading
  gem 'shotgun'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
end

# # Frame2 embed...
# gem "roda", "~> 2.1.0"
# gem "bcrypt", "~> 3.1.10"
# gem "rack-protection", "~> 1.5.3"
# gem "rack_csrf", "~> 2.5.0"
# # END...

gem 'pg'

group :test do
  gem 'minitest'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
