class GenresController < ApplicationController
  def show
    @genre = Genre.find_by(slug: params[:genre])
    render file: "public/404" if @genre.nil?
  end
end
