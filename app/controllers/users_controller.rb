class UsersController < ApplicationController
    before_action :set_user,only:[:show,:edit,:update,:destroy]
    before_action :require_login,only:[:show,:edit,:update]
    before_action :require_permission,only:[:edit,:update,:destroy]
    
    def new
        @user = User.new
    end

    def show
        set_user
        @articles = @user.articles.paginate(page: params[:page], per_page: 3)
    end

    def index
        @users = User.paginate(page: params[:page], per_page:4)

    end
    
    def create
        @user = User.new(parameters)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "hi #{@user.username} you have successfully signed in"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    
    def edit 
        set_user
    end
    def update
        set_user
        if @user.update(parameters)
            flash[:notice] = "Hey #{@user.username} you have successfully updated"
            redirect_to user_path
        else
            render 'edit'
        end
    end
    def destroy
        @user.destroy
        if current_user == @user
            session[:user_id] = nil 
            flash[:notice] = "user and articles deleted successfully"
            redirect_to login_path
        end
    end
    private
    def set_user
        @user = User.find(params[:id])
    end
    def parameters
        params.require(:user).permit(:username,:email,:password_digest)
    end
    def require_login
        if !logged_in?
            flash[:alert] = "loginn avvu mundhu"
            redirect_to login_path
        end
    end
    def require_permission
        if current_user.username != @user.username && !current_user.admin?
            flash[:alert] = "neeku andhuku ra pakkanodi profile"
            redirect_to user_path(@user.id)
        end
    end
end
