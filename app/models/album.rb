class Album < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  has_many :album_reviews
  has_many :reviews, through: :album_reviews

  belongs_to :artist
  belongs_to :genre

  has_many :order_albums
  has_many :orders, through: :order_albums

  validates :title,       presence: true, uniqueness: { scope: :artist_id }
  validates :description, presence: true
  validates :price,       presence: true
  validates :slug,        presence: true, uniqueness: true

  def self.discovery(count)
    limit(count).order("RANDOM()")
  end

  def to_param
    slug
  end

  def formatted_price(quantity = 1)
    number_with_precision((price * quantity) / 100.0, precision: 2)
  end
end
