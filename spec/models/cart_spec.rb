require "rails_helper"

RSpec.describe Cart, type: :model do
  it "has initial contents" do
    cart = Cart.new( { "1" => 1 } )

    expected_cart = { "1" => 1 }

    expect(cart.contents).to eq(expected_cart)
  end

  it "can add an album" do
    cart = Cart.new( { "1" => 1 } )

    cart.add_album(1)
    cart.add_album(2)

    expected_cart = { "1" => 2, "2" => 1}

    expect(cart.contents).to eq(expected_cart)
  end

  it "can return cart total number of items" do
    cart = Cart.new( { "1" => 3, "2" => 1, "3" => 3 } )

    expect(cart.total).to eq(7)
  end
end
