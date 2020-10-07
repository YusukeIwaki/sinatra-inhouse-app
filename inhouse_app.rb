require 'sinatra/base'

class InhouseApp < Sinatra::Base
  use Rack::Session::Cookie
  use OmniAuth::Builder do
    provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
  end

  helpers do
    def authorize!
      unless authenticated?
        redirect to('/auth/github')
      end
      unless authorized?
        halt 403, 'Forbidden. <a href="/logout">Logout</a>'
      end
    end

    def authenticated?
      session[:user]
    end

    def authorized?
      session[:user] == 'YusukeIwaki'
    end
  end

  get '/' do
    authorize!
    '<h1>It works!</h1>'
  end

  get '/auth/github/callback' do
    auth_hash = request.env['omniauth.auth']
    session[:user] = auth_hash['extra']['raw_info']['login']
    redirect to('/')
  end

  get '/logout' do
    session[:user] = nil
    redirect to('/')
  end
end
