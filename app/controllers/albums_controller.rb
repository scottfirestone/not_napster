class AlbumsController < ApplicationController
  def index
    @genres = Genre.all
    @albums = Album.all
  end
end
