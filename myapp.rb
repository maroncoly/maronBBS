# myapp.rb
require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'mysql2'

# DB設定ファイルの読み込み
ActiveRecord::Base.configurations = YAML.load_file('database.yml')
ActiveRecord::Base.establish_connection(:development)

class Post < ActiveRecord::Base
end

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
