class Admin::AlbumsController < Admin::BaseController
  def new
    @album   = Album.new
    @genres  = Genre.all
    @artists = Artist.all
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:message] = "#{@album.title} has been created!"
      redirect_to album_path(@album)
    else
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :slug, :artist_id, :genre_id, :description, :image_url, :release_year, :price)
  end
end
