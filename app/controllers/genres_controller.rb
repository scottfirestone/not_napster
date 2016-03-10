class GenresController < ApplicationController
  def show
    @genre = Genre.find_by(slug: params[:genre])
    @albums = @genre.albums.unexpired_albums
    render file: "public/404" if @genre.nil?
  end
end
