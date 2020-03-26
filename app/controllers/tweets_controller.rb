class TweetsController < ApplicationController
  
  get '/tweets' do
    redirect '/login' if !session[:uid]
    @tweets = Tweet.all
    @user = User.find(session[:uid])
  
    erb :'tweets/index'
  end

  post '/tweets' do
    Helpers.current_user(session).tweets.build(content: params[:content]).save if !params[:content].empty?
    redirect 'tweets/new'
  end

  delete '/tweets' do
    redirect '/login' if !session[:uid]
    tweet = Tweet.find_by(id: params[:tweet_id])
    redirect '/tweets' if !(tweet.user.id == session[:uid])
    tweet.destroy
    redirect '/tweets'
  end
  
  patch '/tweets' do
    redirect "tweets/#{params[:tweet_id]}/edit" if params[:content].empty?
    tweet = Tweet.find_by(id: params[:tweet_id])
    redirect '/tweets' if !(tweet.user.id == session[:uid])
    tweet.update(content: params[:content])
    redirect "tweets/#{params[:tweet_id]}"
  end

  get '/tweets/new' do
    redirect '/login' if !session[:uid]
    erb :'/tweets/new'
  end
  
  get '/tweets/:id' do
    redirect '/login' if !session[:uid]
    @tweet = Tweet.find_by(id: params[:id])  

    erb :'tweets/show'
  end

  get '/tweets/:id/edit' do
    redirect '/login' if !session[:uid]
    @tweet = Tweet.find_by(id: params[:id])
    erb :'/tweets/edit'
  end

end
