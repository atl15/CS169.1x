class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:sort]
      sort = params[:sort]
      session[:sort] = sort
    else
      sort = session[:sort]
    end
    case sort
    when 'title'
      @title_header = 'hilite'
    when 'release_date'
      @relaese_date_header = 'hilite'
    end

    @all_ratings = Movie.all_ratings
    if params[:ratings]
      @selected_ratings = params[:ratings]
      session[:ratings] = @selected_ratings
    elsif session[:ratings]
      @selected_ratings = session[:ratings]
    else
      @selected_ratings = Hash[@all_ratings.map { |rating| [rating, rating] } ]
    end

    if params[:sort] != session[:sort] || params[:ratings] != session[:ratings]
      redirect_to movies_path(sort: session[:sort], ratings: session[:ratings])
    end

    @movies = Movie.where(rating: @selected_ratings.keys).order(sort)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
