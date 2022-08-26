class ArticlesController < ApplicationController
  before_action :set_article, only: [:show,:edit,:update,:destroy]

  before_action :require_login
  before_action :require_permission, only: [:edit,:update,:destroy]

    def show
        @article = Article.find(params[:id])
      end
    
      def index
        @article = Article.paginate(page: params[:page], per_page: 3)
      end
    
      def new
        @article = Article.new
      end
    
      def edit
        @article = Article.find(params[:id])
      end
    
      def create
        @article = Article.new(params.require(:article).permit(:tittle,:description))
        @article.user = current_user
        if @article.save
          flash[:notice] = "Article saved succesfully!"
          #render plain: @article.inspect
          redirect_to @article
          
        else
          render 'new'
        end
      end
      def update
        @article = Article.find(params[:id])
        
          if @article.update(params.require(:article).permit(:tittle,:description))
    
            flash[:notice] = "Article updated succesfully"
            redirect_to article_path(@article)
          else
            render 'edit'
          end
        
    
      end
    
      def destroy
        @article = Article.find(params[:id])
        if @article.destroy
          redirect_to articles_path
        end
      end

      private
      def set_article
        @article = Article.find(params[:id])
      end
      def require_login
        if !logged_in?
          flash[:alert] = "please login in"
          redirect_to login_path
        end
      end

      def require_permission
        if current_user != @article.user && !current_user.admin?
          flash[:alert] = "Thats not your article"
          redirect_to articles_path
        end
      end
    
end
