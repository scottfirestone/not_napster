class OrderAlbum < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :order
  belongs_to :album

  def sub_total
    price * quantity
  end

  def formatted_sub_total
    number_with_precision(sub_total / 100.0, precision: 2)
  end

  def price
    album.price
  end
end
