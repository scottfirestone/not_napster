class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.string :description
      t.string :image_url
      t.string :release_year
      t.integer :price

      t.timestamps null: false
    end
  end
end
