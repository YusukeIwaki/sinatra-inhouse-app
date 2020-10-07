require 'sinatra/base'

class InhouseApp < Sinatra::Base
  get '/' do
    '<h1>It works!</h1>'
  end
end
