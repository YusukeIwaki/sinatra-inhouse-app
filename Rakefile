require "sinatra/activerecord/rake"

namespace :db do
  task :load_config do
    require "bundler/setup"
    Bundler.require
    require "./inhouse_app"
  end
end
