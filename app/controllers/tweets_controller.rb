class TweetsController < ApplicationController
    get '/tweets' do
        if Helpers.logged_in?(session)
            @user = Helpers.current_user(session)
            @tweets = Tweet.all
            erb :"/tweets/tweets"
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if Helpers.logged_in?(session)
            erb :"/tweets/new"
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if params[:content] != ""
            user = Helpers.current_user(session)
            tweet = Tweet.new(content: params[:content])
            tweet.user = user
            tweet.save
        else
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do
        if Helpers.logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            erb :"/tweets/show_tweet"
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        if Helpers.logged_in?(session)
            erb :"/tweets/edit_tweet"
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        tweet = Tweet.find_by_id(params[:id])
        if params[:content] != ""
            tweet.content = params[:content]
            tweet.save
        else
            redirect "/tweets/#{tweet.id}/edit"
        end
    end

    delete '/tweets/:id' do
        tweet = Tweet.find_by_id(params[:id])
        if Helpers.logged_in?(session) && tweet.user_id == session[:user_id]
            tweet.delete
        end
    end
end
