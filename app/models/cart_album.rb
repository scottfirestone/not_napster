class CartAlbum < SimpleDelegator
  attr_accessor :quantity
  attr_reader :album

  def initialize(album_id, quantity)
    @album = Album.find(album_id)
    @quantity = quantity
    super(@album)
  end

  def subtotal
    album.price * quantity
  end
end
