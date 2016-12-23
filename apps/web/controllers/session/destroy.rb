module Web::Controllers::Session
  class Destroy
    include Web::Action

    def call(params)
      env['warden'].logout
      flash.success = 'Successfully logged out'
    end
  end
end
