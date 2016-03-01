class GenresController < ApplicationController
  def show
    @genre = Genre.find_by(name: params[:genre].capitalize)
    render file: "public/404" if @genre.nil?
  end
end
