require 'hanami/model'
require 'hanami/mailer'
Dir["#{ __dir__ }/exporter/**/*.rb"].each { |file| require_relative file }

Hanami::Model.configure do
  ##
  # Database adapter
  #
  # Available options:
  #
  #  * Memory adapter
  #    adapter type: :memory, uri: 'memory://localhost/exporter_development'
  #
  #  * SQL adapter
  #    adapter type: :sql, uri: 'sqlite://db/exporter_development.sqlite3'
  #    adapter type: :sql, uri: 'postgres://localhost/exporter_development'
  #    adapter type: :sql, uri: 'mysql://localhost/exporter_development'
  #
  adapter type: :sql, uri: ENV['EXPORTER_DATABASE_URL']

  ##
  # Migrations
  #
  migrations 'db/migrations'
  schema     'db/schema.sql'

  ##
  # Database mapping
  #
  # Intended for specifying application wide mappings.
  #
  # You can specify mapping file to load with:
  #
  # mapping "#{__dir__}/config/mapping"
  #
  # Alternatively, you can use a block syntax like the following:
  #
  mapping do
    collection :inco_terms do
      entity     IncoTerm
      repository ExpRepository

      attribute :id,         Integer
      attribute :inco_term,  String
    end
  end
end.load!

# Hanami::Mailer.configure do
#   root "#{ __dir__ }/exporter/mailers"
#
#   # See http://hanamirb.org/guides/mailers/delivery
#   delivery do
#     development :test
#     test        :test
#     # production :stmp, address: ENV['SMTP_PORT'], port: 1025
#   end
# end.load!

