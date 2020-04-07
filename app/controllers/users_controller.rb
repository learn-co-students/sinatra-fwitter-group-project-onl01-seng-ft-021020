class UsersController < ApplicationController
    
    get '/signup' do 
        if logged_in?
            # binding.pry
            redirect "/tweets"
        end 

        erb :"/users/new"
    end 

    post '/signup' do 
        
        @user = User.create(params)

        if @user.valid?
            @user.save 
            session[:user_id] = @user.id
            redirect "/tweets"
            
        else 
            redirect "/signup"
        end 
    end 

    get '/login' do 
        if logged_in?
            redirect "/tweets"
        end 

        erb :"/users/login"
    end 

    post '/login' do 
       
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/tweets"
        else 
            erb :"/users/login"
        end 
    end 

    get '/users/:slug' do
        # binding.pry
        @user = User.find_by_slug(params[:slug])
        erb :'/users/show'
      end

    get '/logout' do 
        # binding.pry
        if logged_in?
            session.clear
            redirect "/login"
        else 
            redirect '/'
        end 
        erb :logout
    end 

 
end
