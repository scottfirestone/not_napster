require "rails_helper"

RSpec.feature "Guest can checkout" do
  scenario "they see the order confirmation page" do
    user   = FactoryGirl.create(:user)
    FactoryGirl.create(:album)

    visit albums_path
    click_button "Add to cart"

    visit carts_path

    click_link "Checkout"

    expect(current_path).to eq(login_path)

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Login"

    expect(current_path).to eq(dashboard_path)

    visit carts_path

    click_link "Checkout"
    expect(current_path).to eq(new_order_path)

    expect(page).to have_content("Confirm Your Order")
    expect(page).to have_content("Email: #{user.email}")
    expect(page).to have_content("Title 5")
    expect(page).to have_content("$1.00")
    expect(page).to have_content("1")
    expect(page).to have_content("$1.00")

    expect(page).to have_content("Total: $1.00")
    click_button "Confirm Order"

    expect(page).to have_content("Order #{Order.last.id} was successfully placed!")
  end

  scenario "their cart is empty" do
    user   = FactoryGirl.create(:user)
    FactoryGirl.create(:album)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit albums_path

    click_button "Add to cart"

    expect(page).to have_content("Cart ( 1 )")

    visit carts_path

    click_link "Checkout"

    click_button "Confirm Order"

    expect(page).to_not have_content("Cart ( 1 )")
  end
end
