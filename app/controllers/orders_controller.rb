class OrdersController < ApplicationController
  def new
    if current_user
      @order = Order.new
      @order_albums = CompleteOrder.create_order_albums(session[:cart])
      @publishable_key = ENV['PUBLISHABLE_KEY']
    else
      redirect_to login_path
    end
  end

  def create
    @order = Order.new(user_id: current_user.id, total: params[:total])

    if @order.save
      @amount = params[:total]

      customer = Stripe::Customer.create(
        email:  params[:stripeEmail],
        source: params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: @amount,
        description: "Rails Stripe customer",
        currency: "usd"
      )

    # rescue Stripe::CardError => each
    #   flash[:error] = e.message
    #   redirect_to new_charge_path

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
