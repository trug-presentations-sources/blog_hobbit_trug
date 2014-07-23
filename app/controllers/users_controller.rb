class Blog::UsersController < Blog::ApplicationController
  def views_path
    'app/views/users/'
  end

  before '/:id/edit' do
    authenticate
    set_user
  end

  get '/new' do
    @user = User.new
    render 'new'
  end

  post '/' do
    @user = User.new(request.params['user'])
    if @user.valid?
      @user.save
      env['x-rack.flash'][:notice] = 'User successfully added.'
      response.redirect '/'
    else
      render 'new'
    end
  end

  get '/:id/edit' do
    render 'edit'
  end

  post '/:id' do
    authenticate
    set_user

    @user.update(request.params['user'])
    if @user.valid?
      @user.save
      env['x-rack.flash'][:notice] = 'Update user information successfully.'
      response.redirect '/'
    else
      render 'edit'
    end
  end
  
  private
  
  def set_user
    @user = current_user
  end
end
