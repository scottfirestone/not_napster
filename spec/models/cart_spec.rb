require "rails_helper"

RSpec.describe Cart, type: :model do
  it "has initial contents" do
    cart = Cart.new({ "1" => 1 })

    expected_cart = { "1" => 1 }

    expect(cart.contents).to eq(expected_cart)
  end

  it "can add an album" do
    cart = Cart.new({ "1" => 1 })

    cart.add_album(1)
    cart.add_album(2)

    expected_cart = { "1" => 2, "2" => 1 }

    expect(cart.contents).to eq(expected_cart)
  end

  it "can return cart total price" do
    album = Album.create(
      title: "The Beatles",
      description: "Good",
      image_url: "picture of stuff",
      release_year: "1976",
      price: 1200
                        )
    cart = Cart.new({ album.id.to_s => 3 })

    expect(cart.formatted_total_price).to eq("36.00")
  end
end