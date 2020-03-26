require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter"
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    redirect '/tweets' if session[:uid]
    erb :signup
  end

  post '/signup' do
    redirect '/signup' if params.values.include?("")
    
    @user = User.create(params)
    session[:uid] = @user.id

    redirect '/tweets'
  end

  get '/login' do
    redirect '/tweets' if session[:uid]
    erb :login
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:uid] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
