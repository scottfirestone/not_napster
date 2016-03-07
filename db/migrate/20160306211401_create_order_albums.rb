class CreateOrderAlbums < ActiveRecord::Migration
  def change
    create_table :order_albums do |t|
      t.references :order, index: true, foreign_key: true
      t.references :album, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
