class UsersController < ApplicationController

  get '/logout' do
    redirect '/' if !session[:uid] 
    session.clear
    redirect '/login'
    # erb :'/users/logout'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @tweets = @user.tweets
    erb :'/users/show'
  end

  # post '/logout' do
  #   binding.pry
  #   session.clear
  #   redirect '/login'
  # end

end
