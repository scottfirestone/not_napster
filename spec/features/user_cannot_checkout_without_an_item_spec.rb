require "rails_helper"

RSpec.feature "User cannot checkout without an item" do
  scenario "cannot checkout with no items" do
    user = User.create(username: "salvi6god",
                       password: "password",
                       email: "email@email.com"
                      )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit cart_path

    expect(page).to have_no_content("Checkout")
    expect(page).to have_content("Cart is empty!")
  end
end
