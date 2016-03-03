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

  def destroy
    @cart.remove_cart_album(params[:id])
    redirect_to carts_path
  end

  def update
    if params["operator"] == "+"
      @cart.add_one(params[:id])
      redirect_to carts_path
    elsif params["operator"] == "-"
      @cart.minus_one(params[:id])
      redirect_to carts_path
    end
  end
end
