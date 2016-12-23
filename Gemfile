source 'https://rubygems.org'

gem 'bundler'
gem 'rake'
gem 'hanami',       '~> 0.9'
gem 'hanami-model', '~> 0.7'

gem 'sass'

gem 'crossbeams-dataminer', path: '/home/james/ra/crossbeams/crossbeams-dataminer'
gem 'crossbeams-layout', path: '/home/james/ra/crossbeams/crossbeams-layout'
gem 'crossbeams-dataminer_portal', path: '/home/james/ra/crossbeams/crossbeams-dataminer_portal'
gem 'crossbeams-rack_middleware', path: '/home/james/ra/crossbeams/crossbeams-rack_middleware'

gem 'warden'
gem 'bcrypt'

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
