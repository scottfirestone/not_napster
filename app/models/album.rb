class Album < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :artist
  belongs_to :genre
  has_many :order_albums
  has_many :orders, through: :order_albums

  def formatted_price
    number_with_precision(price / 100.0, precision: 2)
  end
end
