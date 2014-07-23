class Blog::ArticlesController < Blog::ApplicationController
  def views_path
    'app/views/articles/'
  end

  get '/' do
    @articles = Article.all
    render 'index'
  end

  get '/new' do
    @article = Article.new
    render 'new'
  end

  post '/' do
    @article = Article.new({ user_id: current_user.id }.merge(request.params['article']))
    if @article.valid?
      @article.save
      env['x-rack.flash'][:notice] = 'Article successfully added.'
      response.redirect '/articles'
    else
      render 'new'
    end
  end

  get '/:id' do
    @article = Article.find(id: request.params[:id])

    render 'show'
  end

  get '/:id/edit' do
    authenticate
    set_article

    render 'edit'
  end

  post '/:id' do
    authenticate
    set_article

    @article.update(request.params['article'])
    if @article.valid?
      @article.save
      env['x-rack.flash'][:notice] = 'Update article information successfully.'
      response.redirect '/'
    else
      render 'edit'
    end
  end

  post '/:id/delete' do
    authenticate
    set_article

    @article.delete
    response.redirect '/articles'
  end

  post '/:id/notify_friend' do
    @article = Article.find(id: request.params[:id])
    Pony.mail(to: request.params['email'], from: 'from@example.com', subject: 'Interesting Article', body: mailer_body)

    env['x-rack.flash'][:notice] = 'Successfully sent a message to your friend'
    response.redirect "/articles/#{@article.id}"
  end
  
  private
  
  def set_article
    @article = Article.find(user_id: current_user.id, id: request.params[:id])
    response.redirect '/articles' unless @article
  end

  def mailer_body
    "Your friend #{@sender_name} thinks you may like the following article:\n
    #{@article.title}: http://0.0.0.0:9292/articles/#{@article.id}"
  end
end
