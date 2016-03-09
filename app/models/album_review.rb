class AlbumReview < ActiveRecord::Base
  belongs_to :review
  belongs_to :album
end
