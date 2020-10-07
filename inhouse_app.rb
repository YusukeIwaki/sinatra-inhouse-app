require 'sinatra/base'

class InhouseApp < Sinatra::Base
  use Rack::Session::Cookie
  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
  end

  get '/' do
    '<h1>It works!</h1>'
  end

  get '/auth/github/callback' do
    auth_hash = request.env['omniauth.auth']
    puts auth_hash
    redirect to('/')
  end
end
