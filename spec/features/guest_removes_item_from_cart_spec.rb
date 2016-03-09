require "rails_helper"

RSpec.feature "Guest removes an item from cart" do
  scenario "they no longer see the removed item and cart total shows $0.00" do
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
    expect(page).to have_content "Total: $#{album.formatted_price}"

    click_on "Remove"

    expect(page).to_not have_css("img[src*='#{album.image_url}']")
    expect(page).to_not have_content album.title
    expect(page).to_not have_content album.description
    expect(page).to_not have_content album.formatted_price
    expect(page).to_not have_content "Total: $1.00"

    expect(page).to have_content("Total: $0.00")
  end
end
