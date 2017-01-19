require './config/environment'

#require '../frame2/frame2'

# map '/frame3' do
#   use ApplicationController
# end

use Crossbeams::RackMiddleware::Banner, template: 'apps/web/templates/shared/_banner_template.html.erb'

  Warden::Manager.serialize_into_session{|user| user.id }
  Warden::Manager.serialize_from_session{|id| UserRepository.new.find(id) }

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:password) do
    def valid?
      params['session'] && params['session']['name'] && params['session']['password']
    end

    def authenticate!
      user = UserRepository.new.authenticate(
        params['session']['name'],
        params['session']['password']
        )
      user.nil? ? fail!('Could not log in') : success!(user, 'Successfully logged in')
    end
  end

  use Warden::Manager do |config|
    config.scope_defaults :default,
      strategies: [:password],
      action: '/' #'/session/failure'
    config.failure_app = self
  end

# Is this BEFORE warden?......
# map "/#{ENV['DM_PREFIX']}" do #Where to mount dataminer
#   run Crossbeams::DataminerPortal::WebPortal.new
# end

map '/' do
  run Hanami.app
end

#run Hanami::Container.new
