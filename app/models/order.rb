class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :user
  has_many :order_albums
  has_many :albums, through: :order_albums
  has_many :orders

  before_save :total

  def formatted_total
    number_with_precision(total / 100.0, precision: 2)
  end

  def total
    CompleteOrder.calculate_total
  end
end
