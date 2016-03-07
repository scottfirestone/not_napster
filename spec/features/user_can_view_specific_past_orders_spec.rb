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

    visit carts_path
    click_link "Checkout"
    click_button "Confirm Order"

    visit albums_path
    within(".preview:nth-of-type(2)") do
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

    #clicking the user's first order
    click_link "Order Number: #{user.orders.first.id}"
    save_and_open_page
    expect(current_path).to eq(order_path(user.orders.first.id))

    #Then I should see each item that was ordered with the quantity and line-item subtotals

    # THIS IS FOR THE SECOND ORDER VIEW
    # THIS IS OPTIONAL
    # click_link "Order Number: #{user.order.last.id}"
  end
end

    # Background: An existing user that has one previous order
    #   As an authenticated user
    #   When I visit "/orders"
    #   Then I should see my past order
    #   And I should see a link to view that order
    #   And when I click that link
    #   Then I should see each item that was order with the quantity and line-item subtotals
    #   And I should see links to each item's show page
    #   And I should see the current status of the order (ordered, paid, cancelled, completed)
    #   And I should see the total price for the order
    #   And I should see the date/time that the order was submitted
    #   If the order was completed or cancelled
    #   Then I should see a timestamp when the action took place
    #   And if any of the items in the order were retired from the menu
    #   Then they should still be able to access the item page
    #   But they should not be able to add the item to their cart
