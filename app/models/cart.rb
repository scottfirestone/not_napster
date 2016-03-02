class Cart
  include ActionView::Helpers::NumberHelper

  attr_reader :contents, :quantity

  def initialize(initial_contents)
    @contents = initial_contents || {}
    @quantity = contents.values.sum
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

  def album_quantity(album_id)
    @contents[album_id.to_s]
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

  def add_one
    #ignore
    @quantity += 1
  end
end
