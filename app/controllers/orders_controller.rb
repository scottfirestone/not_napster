class OrdersController < ApplicationController
  def new
    if current_user
      @order = Order.new
      @order_albums = CompleteOrder.create_order_albums(session[:cart])
    else
      redirect_to login_path
    end
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      session[:order_id] = @order.id
      session[:cart].clear
      redirect_to @order
    else
      flash.now[:notice] = "Sorry, something went wrong with your order!"
      render :new
    end
  end

  def show
    @order = Order.find(session[:order_id])
  end

  private

  def order_params
    params.require(:order).permit(:total, :user_id)
  end
end
