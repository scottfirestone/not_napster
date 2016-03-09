class AlbumsController < ApplicationController
  def index
    @genres = Genre.all
    @albums = Album.all
    @featured_album = Album.take
  end

  def show
    @album = Album.find_by(slug: params[:id])
  end
end
