class Blog::RootController < Blog::ApplicationController
  def views_path
    'app/views/'
  end

  get '/' do
    response.redirect '/articles'
  end

  get '/login' do
  	render 'sessions/new'
  end

  post '/session' do
    user = User.find(email: request.params['email'])
    if user && user.authenticate(request.params['password'])
      session[:user_id] = user.id
      env['x-rack.flash'][:notice] = 'Logged in successfully'
      response.redirect '/'
    else
      env['x-rack.flash'][:alert] = 'Invalid login/password combination'
      env['x-rack.flash'].flag!
      render 'sessions/new'
    end
  end

  get '/logout' do
    session[:user_id] = nil
    env['x-rack.flash'][:notice] = 'You have successfully logged out'
    response.redirect '/'
  end
end
