class CompleteOrder
  attr_reader :order_albums

  def self.create_order_albums(cart)
    @order_albums = cart.map do |cart_item|
      OrderAlbum.new(album_id: cart_item[0].to_i, quantity: cart_item[1])
    end
  end

  def self.calculate_total
    @order_albums.reduce(0) do |sum, order_album|
      sum + (order_album.price * order_album.quantity)
    end
  end
end