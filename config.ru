require './config/environment'

#require '../frame2/frame2'

# map '/frame3' do
#   use ApplicationController
# end

use Crossbeams::RackMiddleware::Banner, template: 'apps/web/templates/shared/_banner_template.html.erb'

map "/#{ENV['DM_PREFIX']}" do #Where to mount dataminer
  run Crossbeams::DataminerPortal::WebPortal.new
end

map '/' do
  run Hanami.app
end

#run Hanami::Container.new
