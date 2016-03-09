class OrdersController < ApplicationController
  def new
    if current_user
      @order = Order.new
      @order_albums = OrderProcessor.prepare_order_albums(session[:cart])
    else
      redirect_to login_path
    end
  end

  def create
    @order = Order.new(user_id: current_user.id, total: params[:total])

    if @order.save
      process_credit_card unless Rails.env.test?
      OrderProcessor.finalize_order(session, @order)
      flash[:message] = "Order #{@order.id} was successfully placed!"
      redirect_to @order
    else
      flash.now[:notice] = "Sorry, something went wrong with your order!"
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:total, :user_id)
  end

  def process_credit_card
    customer = Stripe::Customer.create(
      email:  params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: params[:total],
      description: "Rails Stripe customer",
      currency: "usd"
    )

  rescue Stripe::CardError => each
    flash[:error] = each.message
    redirect_to new_order_path
  end
end
