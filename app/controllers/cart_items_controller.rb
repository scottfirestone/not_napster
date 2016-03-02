class CartItemsController < ApplicationController
  def destroy
    Cart.contents.delete(params[:id])
  end
end
