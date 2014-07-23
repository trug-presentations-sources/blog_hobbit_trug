namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |t, args|
    require 'sequel'
    require 'sqlite3'

    Sequel.extension :migration
    db = Sequel.sqlite('db/blog.sqlite3')
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, 'db/migrations', target: args[:version].to_i)
    else
      puts 'Migrating to latest'
      Sequel::Migrator.run(db, 'db/migrations')
    end
  end
end

desc 'Start a console'
task :console do
  require 'pry'
  require_relative 'config/application'

  ARGV.clear
  Pry.start
end

require 'rake/sprocketstask'
require 'uglifier'

Rake::SprocketsTask.new do |t|
  environment = Sprockets::Environment.new
  environment.append_path 'app/assets/images'
  environment.append_path 'app/assets/javascripts'
  environment.append_path 'app/assets/stylesheets'
  environment.js_compressor  = :uglify
  environment.css_compressor = :scss

  t.environment = environment
  t.manifest = Sprockets::Manifest.new(environment, "public/assets/manifest.json")

  t.output = 'public/assets'
  t.assets = %w(application.js application.css)
end