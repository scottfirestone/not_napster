class AlbumRetriever < SimpleDelegator

  def initialize(album_id, quantity)
    @album = Album.find(album_id)
    @quantity = quantity
    super(@album)
  end
end
