require 'hobbit'
require 'hobbit/session'
require 'hobbit/render'
require 'hobbit/filter'
require 'rack-protection'
require 'sprockets'
require 'sequel'
require 'rack-flash'
require 'securerandom'
require 'pony'

Sequel::Model.plugin :timestamps

module Blog
  class Application < Hobbit::Base
    Dir[File.join('config', 'initializers', '**/*.rb')].each { |file| require File.expand_path(file) }
    Dir[File.join('app', 'controllers', '**/*.rb')].each { |file| require File.expand_path(file) }
    Dir[File.join('app', 'models', '**/*.rb')].each { |file| require File.expand_path(file) }

    if ENV['RACK_ENV'] == :development
      require 'better_errors'
      use BetterErrors::Middleware
    end

    include Hobbit::Session
    use Rack::Session::Cookie, secret: SecureRandom.hex(64)

    use Rack::Flash, sweep: true

    # must be used after Rack::Session::Cookie
    use Rack::Protection, except: :http_origin

    map '/assets' do
      environment = Sprockets::Environment.new
      environment.append_path 'app/assets/images'
      environment.append_path 'app/assets/javascripts'
      environment.append_path 'app/assets/stylesheets'
      run environment
    end

    map('/') { run RootController.new }
    map('/users') { run UsersController.new }
    map('/articles') { run ArticlesController.new }
  end
end
