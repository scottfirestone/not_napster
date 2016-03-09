class AddExpiryDateToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :expiry_date, :datetime, default: (Time.now + 6.months)
  end
end
