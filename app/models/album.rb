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
  validates :expiry_date, presence: true

  def self.discovery(count)
    # unexpired_albums.limit(count).order("RANDOM()")
    unexpired_albums.sample(4)
  end

  def self.unexpired_albums
    all.reject(&:expired?)
  end

  def to_param
    slug
  end

  def formatted_price
    number_with_precision(price / 100.0, precision: 2)
  end

  def expired?
    Time.now > expiry_date
  end

  def status
    if expired?
      "Expired"
    else
      "Valid"
    end
  end
end
