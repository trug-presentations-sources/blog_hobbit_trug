class Blog::ApplicationController < Blog::Application
  include Hobbit::Render
  include Hobbit::Session
  include Hobbit::Filter

  def template_engine
    'haml'
  end

  def layouts_path
    'app/views/layouts'
  end

  def current_user
    @current_user ||= User.with_pk(session[:user_id])
  end

  def authenticate
    unless current_user
      env['x-rack.flash'][:notice] = 'Please log in to continue'
      response.redirect '/login'
    end
  end
end
