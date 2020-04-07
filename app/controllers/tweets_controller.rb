class TweetsController < ApplicationController

    get '/tweets' do 
        
        if logged_in?
            @user = User.find_by(id: session[:user_id])
            # binding.pry
            erb :"/tweets/index"
        else 
            redirect "/login"
        end 
    end 

    get '/tweets/new' do 
        
        if logged_in?
            @user = User.find_by(id: session[:user_id])
            erb :"/tweets/new"
        else 
            redirect '/login'
        end 
    end 

    post '/tweets' do
        
        if !logged_in?
            redirect '/login'
        end 
        # binding.pry
        if !params[:content].empty?
            current_user
            @tweet = Tweet.new(content: params["content"], user_id: @user.id)
            @tweet.save
            redirect '/tweets'
        else 
            redirect '/tweets/new'
        end         
    end  

    get '/tweets/:id' do
        if !logged_in?
          redirect '/login'
        end
        # binding.pry
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/show'
      end
 
    get '/tweets/:id/edit' do 
        if !logged_in?
            redirect '/login'
        else 
            @tweet = Tweet.find(params[:id])
            if @tweet.user = current_user
                erb :"/tweets/edit"
            else 
                redirect '/login'
            end 
        end 
    end 

    patch '/tweets/:id' do 
        @tweet = Tweet.find(params[:id])
        # binding.pry
        if !params[:content].empty?
            # binding.pry
            @tweet.update(content: params[:content])
            
            redirect "/tweets/#{@tweet.id}"
        else 
            redirect "/tweets/#{@tweet.id}/edit"
        end 
    end 

    delete '/tweets/:id/delete' do 
        if !logged_in?
            redirect '/login'
        end 
        @tweet = Tweet.find(params[:id])
        if @tweet.user == current_user
            @tweet.delete
            redirect '/tweets'
        else 
            redirect '/login'
        end 
    end 

end
