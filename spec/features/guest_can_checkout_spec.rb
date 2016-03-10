require "rails_helper"

RSpec.feature "Guest can checkout" do
  scenario "they see the order confirmation page" do
    user   = FactoryGirl.create(:user)
    album  = FactoryGirl.create(:album)

    visit albums_path
    within(".preview") do
      click_on "Add to cart"
    end

    visit cart_path

    click_button "Checkout"

    expect(current_path).to eq(login_path)

    fill_in "Username", with: user.username
    fill_in "Password", with: user.password
    click_button "Login"

    expect(current_path).to eq(dashboard_path)

    visit cart_path

    click_button "Checkout"
    expect(current_path).to eq(new_order_path)

    expect(page).to have_content("Confirm Your Order")
    expect(page).to have_content("#{album.title}")
    expect(page).to have_content("#{album.formatted_price}")
    expect(page).to have_content("#{album.title}")
    expect(page).to have_content("$1.00")
    expect(page).to have_content("1")

    expect(page).to have_content("Total")
    click_button "Confirm Order"

    expect(page).to have_content("Order #{Order.last.id} was successfully placed!")
  end

  scenario "their cart is empty" do
    user   = FactoryGirl.create(:user)
    FactoryGirl.create(:album)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit albums_path

    within(".preview") do
      click_on "Add to cart"
    end

    expect(page).to have_content("Cart ( 1 )")

    visit cart_path

    click_button "Checkout"

    click_button "Confirm Order"

    expect(page).to_not have_content("Cart ( 1 )")
  end

  context "when their is an order error" do
    scenario "they see an error message" do
      user   = FactoryGirl.create(:user)
      album  = FactoryGirl.create(:album)
      invalid_user = User.new()

      visit albums_path
      within(".preview") do
        click_on "Add to cart"
      end
      visit cart_path
      click_button "Checkout"
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Login"
      visit cart_path
      click_button "Checkout"

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(invalid_user)

      click_button "Confirm Order"

      within(".notice") do
        expect(page).to have_content("Sorry, something went wrong with your order!")
      end
    end
  end
end
