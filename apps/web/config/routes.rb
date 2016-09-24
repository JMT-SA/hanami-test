#post '/books/:id', to: 'books#update'
# get '/books/:id/edit', to: 'books#edit'
get '/books/container', to: 'books#container', as: 'bookcontainer'
get '/books/calledback', to: 'books#calledback', as: 'bookback'
# post '/books', to: 'books#create'
# get '/books/new', to: 'books#new'
# get '/books', to: 'books#index'
resources :books, except: :show
get '/books/grid', to: 'books#grid', as: 'bookgrid'
get '/print_grid', to: 'grids#print_grid'

get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/blurt', to: ->(env) { [200, {}, [File.read('.ruby-version')]] } # Could make a quick URL to show version/config info

# mount SinatraApp.new, at: '/sinatra'
#mount Frame2.app, at: '/frame2'
#mount FloatingCanvas::Webtest::MySinatraApp.new, at: '/sinatra'

get '/', to: 'home#index'
# See: http://www.rubydoc.info/gems/hanami-router/#Usage
