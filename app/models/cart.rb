class Cart
  include ActionView::Helpers::NumberHelper

  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def quantity
    contents.values.sum
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
      CartAlbum.new(album_id, quantity)
    end
  end

  def total_price
    cart_albums.reduce(0) do |sum, cart_album|
      sum + cart_album.subtotal
    end
  end

  def formatted_total_price
    number_with_precision(total_price / 100.0, precision: 2)
  end

  def add_one(album_id)
    @contents[album_id.to_s] += 1
  end

  def minus_one(album_id)
    @contents[album_id.to_s] -= 1
  end

  def change_quantity(operator, album_id)
    if operator == "+"
      add_one(album_id)
    elsif operator == "-"
      minus_one(album_id)
    end
    remove_cart_album(album_id) if contents[album_id] == 0
  end

  def navigation_quantity
    "( #{quantity} )" unless quantity.zero?
  end

  def empty?
    quantity == 0
  end
end
