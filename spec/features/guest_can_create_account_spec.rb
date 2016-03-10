require "rails_helper"

RSpec.feature "Guest can create an account" do
  scenario "they see their dashboard" do
    visit root_path

    within(".site-nav") do
      expect(page).to have_link("Login")
    end

    click_link "Create Account"
    fill_in "Username", with: "julsfelic"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Create Account"

    user = User.last

    expect(current_path).to eq(dashboard_path)

    within(".site-nav") do
      expect(page).to have_content(user.username)
    end

    within(".user-sidebar") do
      expect(page).to have_link("Account Details")
      expect(page).to have_link("Update Account")
      expect(page).to have_link("Past Orders")
    end

    within(".user") do
      expect(page).to have_content("Account Details")
      expect(page).to have_content("Username: #{user.username}")
      expect(page).to have_content("Email: #{user.email}")
    end

    within(".site-nav") do
      expect(page).to_not have_link("Login")
      expect(page).to have_link("Logout")
    end
  end

  context "without username" do
    scenario "they see an error message" do
      visit root_path

      click_link "Create Account"
      fill_in "Username", with: ""
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "password"
      click_button "Create Account"

      within ".errors" do
        expect(page).to have_content "Invalid Account Details"
      end
    end
  end

  context "with album in the cart" do
    scenario "they still have the album in their cart" do
      album = FactoryGirl.create(:album)

      visit albums_path
      within(".preview") do
        click_on "Add to cart"
      end
      click_link "Cart"

      expect(page).to have_css("img[src*='#{album.image_url}']")
      expect(page).to have_content album.title
      expect(page).to have_content album.description
      expect(page).to have_content album.formatted_price
      expect(page).to have_content "Total: $1.00"

      visit root_path
      click_link "Create Account"
      fill_in "Username", with: "julsfelic"
      fill_in "Email", with: "julsfelic@gmail.com"
      fill_in "Password", with: "password"
      click_button "Create Account"

      visit cart_path

      expect(page).to have_css("img[src*='#{album.image_url}']")
      expect(page).to have_content album.title
      expect(page).to have_content album.description
      expect(page).to have_content album.formatted_price
      expect(page).to have_content "Total: $1.00"

      click_link "Logout"

      within(".site-nav") do
        expect(page).to_not have_link("Logout")
        expect(page).to have_link("Login")
      end
    end
  end
end
