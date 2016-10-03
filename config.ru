require './config/environment'

#require '../frame2/frame2'
#REQUIRE '../DM_TESTS/PG_TREE'

# map '/frame3' do
#   use ApplicationController
# end
#require 'crossbeams/dataminer_portal'

# map '/frame_sin' do
#   use Crossbeams::DataminerPortal::WebPortal
# end
# config.ru
#map '/sinatra' do
map "/#{ENV['DM_PREFIX']}" do #Where to mount dataminer
  run Crossbeams::DataminerPortal::WebPortal.new
end

map '/' do
  run Hanami::Container.new
end

#run Hanami::Container.new
