class CartsController < ApplicationController
  def index

  end

  def create
    album = Album.find(params[:album_id])
    @cart.add_album(album.id)
    session[:cart] = @cart.contents
    flash[:info] = "You have added #{album.title} to the cart."
    redirect_to albums_path
  end
end
