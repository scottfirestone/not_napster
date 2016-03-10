require "rails_helper"

RSpec.feature "Existing user can view past orders" do
  scenario "they see their past orders" do
    FactoryGirl.create(:album)
    FactoryGirl.create(:album)

    user = User.create(username: "salvi6god",
                        password: "password",
                       email: "email@email.com"
                       )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit albums_path
    within(".preview:nth-of-type(1)") do
      click_on "Add to cart"
    end

    visit cart_path
    click_button "Checkout"
    click_button "Confirm Order"

    visit albums_path
    within(".preview:nth-of-type(2)") do
      click_on "Add to cart"
    end

    visit cart_path
    click_button "Checkout"
    click_button "Confirm Order"

    visit dashboard_path

    click_link "Past Orders"

    expect(page).to have_content(user.orders.first.id)
    expect(page).to have_content(user.orders.last.id)

    expect(current_path).to eq(orders_path)
  end
end
