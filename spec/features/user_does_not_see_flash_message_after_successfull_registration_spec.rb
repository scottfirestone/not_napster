require "rails_helper"

RSpec.feature "User does not see flash message after successfull registration" do
  scenario "they do not see the message invalid account details" do
    visit root_path
    click_link "Create Account"
    click_button "Create Account"

    expect(page).to have_content("Invalid Account Details")

    fill_in "Username", with: "julsfelic"
    fill_in "Email",    with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Create Account"

    expect(page).to_not have_content("Invalid Account Details")
  end
end
