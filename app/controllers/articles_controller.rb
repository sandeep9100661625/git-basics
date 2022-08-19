class ArticlesController < ApplicationController
    def show
        @article = Article.find(params[:id])
      end
    
      def index
        @article = Article.all
      end
    
      def new
        @article = Article.new
      end
    
      def edit
        @article = Article.find(params[:id])
      end
    
      def create
        @article = Article.new(params.require(:article).permit(:tittle,:description))
        @article.user = User.first
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
        
      end
    
end
