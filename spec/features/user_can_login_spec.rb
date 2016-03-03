require "rails_helper"

RSpec.feature "User can login" do
  scenario "they see their dashboard" do
    user = FactoryGirl.create(:user)

    visit root_path
    click_link "Login"

    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_button "Login"

    expect(current_path).to eq(dashboard_path)

    within(".user") do
      expect(page).to have_content(user.username)
      expect(page).to have_content(user.email)
    end

    within(".site-header") do
      expect(page).to_not have_link("Login")
      expect(page).to have_link("Logout")
    end
  end

  context "with invalid username" do
    scenario "they get an error message" do
      FactoryGirl.create(:user)

      visit root_path
      click_link "Login"

      fill_in "Username", with: ""
      fill_in "Password", with: "password"
      click_button "Login"

      expect(current_path).to eq(login_path)

      within(".errors") do
        expect(page).to have_content("Invalid Credentials")
      end
    end
  end
end
