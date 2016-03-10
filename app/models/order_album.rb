class OrderAlbum < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :order
  belongs_to :album

  validates_presence_of :price

  def sub_total
    price * quantity
  end

  def title
    album.title
  end

  def formatted_sub_total
    number_with_precision(sub_total / 100.0, precision: 2)
  end

  def price
    album.price
  end

  def time_format
    created_at.strftime("%B %d, %Y")
  end
end
