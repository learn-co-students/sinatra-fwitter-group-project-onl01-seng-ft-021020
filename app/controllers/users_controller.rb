class UsersController < ApplicationController

    get '/signup' do
        if Helpers.logged_in?(session)
            redirect '/tweets'
        end
        erb :"/users/create_user"
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect "/signup"
        else
            user = User.create(username: params[:username], email: params[:email], password: params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        end
    end

    get '/login' do
        if Helpers.logged_in?(session)
            redirect '/tweets'
        end
        erb :"/users/login"
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        end
        redirect '/login'
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @tweets = @user.tweets
        erb :"users/show_user"
    end
end
