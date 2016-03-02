class Cart
  include ActionView::Helpers::NumberHelper

  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_album(album_id)
    contents[album_id.to_s] ||= 0
    contents[album_id.to_s] += 1
  end

  def remove_cart_album(album_id)
    contents.delete(album_id)
  end

  def cart_albums
    @contents.map do |album_id, quantity|
      [Album.find(album_id), quantity]
    end
  end

  def albums
    @contents.map do |album_id, _quantity|
      Album.find(album_id)
    end
  end

  def cart_album_price(cart_album)
    cart_album[0].price * cart_album[1]
  end

  def total_price
    cart_albums.reduce(0) do |sum, cart_album|
      sum + cart_album_price(cart_album)
    end
  end

  def formatted_total_price
    number_with_precision(total_price / 100.0, precision: 2)
  end
end
