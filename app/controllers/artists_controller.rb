class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find_by(slug: params[:artist_name])
    @albums = @artist.albums.unexpired_albums
  end
end
