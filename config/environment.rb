# require 'rubygems'
require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/bookshelf'
#require_relative '../lib/exporter'
require_relative '../apps/web/application'

# Customised
require_relative '../lib/dataminer_control'

Hanami.configure do
  mount Web::Application, at: '/'

  model do

    adapter :sql, ENV['BOOKSHELF_DATABASE_URL']

    migrations 'db/migrations'
    schema     'db/schema.sql'

  end

  mailer do

    # Adjust the new layer `root` location
    root Hanami.root.join("lib", "bookshelf", "mailers")

    delivery do
      development :test
      test        :test
      # production :smtp, address: ENV['SMTP_PORT'], port: 1025
    end
  end
end
