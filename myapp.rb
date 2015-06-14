# myapp.rb
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'mysql2'

require_relative 'init'

# FIXME: DBの接続情報は別に切り出したい。
ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development)

class Server < Sinatra::Base
  get '/' do
    @posts = Post.order('created_at DESC').limit(10)
    erb :index
  end

  post '/post' do
    user_name = params[:user_name]
    body      = params[:body]

    post = Post.new
    post.user_name = user_name
    post.body      = body
    post.save!

    redirect '/'
  end
end
