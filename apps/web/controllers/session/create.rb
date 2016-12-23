module Web::Controllers::Session
  class Create
    include Web::Action

    def call(params)
      params.env['warden'].authenticate!
      flash[:success] = params.env['warden'].message
      redirect_to session[:return_to] || '/'
    end
  end
end
