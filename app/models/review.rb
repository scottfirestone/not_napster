class Review < ActiveRecord::Base
  has_many :album_reviews
  has_many :albums, through: :album_reviews

  validates_presence_of :comment
end
