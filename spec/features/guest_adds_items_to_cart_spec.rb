require "rails_helper"

RSpec.feature "Guest adds items to cart" do
  scenario "they see items with total price" do
    album = FactoryGirl.create(:album)

    visit albums_path
    click_on "Add to cart"
    click_link "Cart"

    expect(current_path).to eq(user_cart_path)
    expect(page).to have_css("img[src*='#{album.image_url}']")
    expect(page).to have_content album.title
    expect(page).to have_content album.description
    expect(page).to have_content album.formatted_price
    within(".total-price") do
      expect(page).to have_content "Total: $1.00"
    end

    visit albums_path
    click_on "Add to cart"
    click_on "Cart"

    within(".total-price") do
      expect(page).to have_content "Total: $2.00"
    end
  end
end
