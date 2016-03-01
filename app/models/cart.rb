class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_album(album_id)
    contents[album_id.to_s] ||= 0
    contents[album_id.to_s] += 1
  end

  def total
    contents.values.sum
  end
end
