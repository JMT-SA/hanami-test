require './config/environment'

require '../frame2/frame2'
#REQUIRE '../DM_TESTS/PG_TREE'

# map '/frame3' do
#   use ApplicationController
# end

run Hanami::Container.new
