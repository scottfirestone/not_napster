class CreateAlbumReviews < ActiveRecord::Migration
  def change
    create_table :album_reviews do |t|
      t.references :album, index: true, foreign_key: true
      t.references :review, index: true, foreign_key: true
    end
  end
end
