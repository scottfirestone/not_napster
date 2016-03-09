require "rails_helper"

RSpec.feature "Existing user can view past orders" do
  scenario "they see their past orders" do
    FactoryGirl.create(:album)

    user = User.create(username: "salvi6god",
                       password: "password",
                       email: "email@email.com"
                      )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit albums_path
    within(".preview") do
      click_on "Add to cart"
    end

    visit carts_path
    click_link "Checkout"
    click_button "Confirm Order"

    visit dashboard_path
    click_link "Past Orders"
    expect(page).to have_content(user.orders.first.id)
    expect(page).to have_content(user.orders.last.id)
    expect(current_path).to eq(orders_path)

    click_link "Order Number: #{user.orders.first.id}"

    order = user.orders.first

    expect(current_path).to eq(order_path(order.id))

    expect(page).to have_content(order.time_format)

    order.order_albums.each do |order_album|
      expect(page).to have_link(order_album.title.to_s, album_path(order_album.album))
      expect(page).to have_content("$#{order_album.formatted_sub_total}")
      expect(page).to have_content(order_album.quantity)
      expect(page).to have_content("$#{order_album.formatted_price}")
    end

    expect(page).to have_content("$#{order.formatted_total}")

    expect(page).to have_content(order.time_format)
  end
end
