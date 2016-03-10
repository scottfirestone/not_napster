class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :user
  has_many :order_albums
  has_many :albums, through: :order_albums
  validates :user_id, presence: true

  def formatted_total
    number_with_precision(get_total / 100.0, precision: 2)
  end

  def get_total
    total || OrderProcessor.calculate_total
  end

  def time_format
    created_at.strftime("%B %d, %Y")
  end
end
