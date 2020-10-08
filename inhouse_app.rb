require 'sinatra/base'
Dir['./app/models/**/*.rb'].each { |f| require_relative f }

ActiveRecord::Base.logger = Logger.new($stdout)
ActiveRecord::Base.verbose_query_logs = true

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

    AuditLog.create!(
      subject: "#{session[:user]} accessed",
      description: "#{session[:user]} accessed on '/'",
    )

    erb :'index.html'
  end

  get '/profile' do
    @form = ProfileForm.new
    erb :'profile.html'
  end

  post '/profile' do
    profile_form_params = params.slice(:name, :age, :address)
    @form = ProfileForm.new(profile_form_params)
    if @form.valid?
      "Profile登録しにいく"
      redirect to('/profile')
    else
      erb :'profile.html'
    end
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
