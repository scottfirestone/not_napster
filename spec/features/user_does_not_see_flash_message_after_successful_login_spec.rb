require "rails_helper"

RSpec.feature "User does not see flash message after successful login" do
  scenario "they see no invalid credentials message" do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link "Login"
    click_button "Login"

    expect(page).to have_content("Invalid Credentials")

    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_button "Login"

    expect(page).to_not have_content("Invalid Credentials")
  end
end
