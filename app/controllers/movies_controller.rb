class MoviesController < ApplicationController
    before_action :set_movie, only: [:show,:edit,:update,:destroy]

  def show
  end

  def index
    @movies = Movie.all
  end
  def new
    @movie = Movie.new
  end
  def create
    @movie= Movie.new(set_params)
    if @movie.save
      flash[:notice] = "Movie detail created succesfully"
      redirect_to @movie
    else
      render 'new'
    end
  end

  def edit
  end

  def update

    if @movie.update(set_params)
      flash[:notice] = "Movie detail updated successfully"
      redirect_to @movie
    else
      render 'edit'
    end
  end

    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      redirect_to movies_path
    end
    private
    def set_movie
      @movie = Movie.find(params[:id])
    end
    def set_params
      params.required(:movie).permit(:movie_name,:director,:hero)
    end
end
