ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require './app/models/database_setup'

class BookMarkManager < Sinatra::Base
  enable :sessions
  set :session_secret, '0ac8368e8d59a45c4d9f5d11f36dbfaa2108a8c0f7b1be98f39933356bcee17a'

  helpers do
     def current_user
       @current_user ||= User.get(session[:user_id])
     end
  end

  get '/' do
    'Hello!'
  end

  get '/links' do
    @links = Link.all
    @current_user = current_user
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/add_link'
  end

  post '/links' do
    link = Link.create(url:params[:url],title:params[:title])
    params[:tags].split(',').each do |tag|
      link.tags << Tag.first_or_create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    user = User.new(email_address: params[:email_address])
    user.password = params[:password]
    user.save!
    session[:user_id] = user.id
    redirect '/links'
  end
end