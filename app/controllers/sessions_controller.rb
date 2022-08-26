class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        user1 = User.find_by(password_digest: params[:session][:password_digest])
        if user && user1
            session[:user_id] = user.id
            flash[:notice] = "you have logged in successfully"
            redirect_to user_path(user.id)
        else
            flash.now[:alert] = "Wrong Login Credentials"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "you have logged out successfully"
        redirect_to root_path

    end

end