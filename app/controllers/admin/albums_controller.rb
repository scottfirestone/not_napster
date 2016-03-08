class Admin::AlbumsController < Admin::BaseController
  def index
    @albums = Album.all
  end

  def new
    @album   = Album.new
    @artists = Artist.all
    @genres  = Genre.all
  end

  def create
    @artists = Artist.all
    @genres  = Genre.all
    @album   = Album.new(album_params)

    if @album.save
      flash[:message] = "#{@album.title} has been created"
      redirect_to album_path(@album)
    else
      flash.now[:errors] = "Invalid Entry"
      render :new
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :slug, :artist_id, :genre_id, :description, :image_url, :release_year, :price)
  end
end
