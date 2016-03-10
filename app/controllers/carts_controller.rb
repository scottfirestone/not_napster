class CartsController < ApplicationController
  def show
  end

  def create
    album = Album.find(params[:album_id])
    @cart.add_album(album.id)
    session[:cart] = @cart.contents
    flash[:info] = "You have added #{album.title} to the cart."
    redirect_to :back
  end

  def destroy
    @cart.remove_cart_album(params[:id])
    redirect_to cart_path
  end

  def update
    @cart.change_quantity(params["operator"], params[:id])
    redirect_to cart_path
  end
end
