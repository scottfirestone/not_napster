require "rails_helper"

RSpec.feature "User cannot purchase expired albums" do
  scenario "they see that the item is no longer available" do
    user = FactoryGirl.create(:user)
    genre = Genre.create(name: "Jazz", slug: "jazz")
    album = FactoryGirl.create(:album)
    album.update(genre_id: genre.id)
    order = user.orders.create(total: 100)
    order.order_albums.create(album_id: album.id, quantity: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(album.expired?).to eq(false)

    album.update(expiry_date: (Time.now - 7.months))

    visit orders_path

    click_on "Order Number: #{order.id}"

    click_on album.title

    expect(current_path).to eq(album_path(album))
    expect(page).to have_content("Album is no longer available")
    expect(page).to_not have_content("Add to cart")
  end
end
