require 'rubygems'
require 'bundler/setup'
require 'hanami/setup'
require_relative '../lib/bookshelf'
require_relative '../apps/web/application'

# Customised
require_relative '../lib/jmt_layout'
require_relative '../lib/dataminer_control'

Hanami::Container.configure do
  mount Web::Application, at: '/'
end
