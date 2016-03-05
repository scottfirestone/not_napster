require "rails_helper"

RSpec.feature "Guest can adjust quantity of an item in the cart" do
  scenario "they can adjust the quantity by adding" do
    album = FactoryGirl.create(:album)
    visit albums_path
    click_on "Add to cart"
    click_link "Cart"

    expect(page).to have_css("img[src*='#{album.image_url}']")
    expect(page).to have_content album.title
    expect(page).to have_content album.description
    expect(page).to have_content album.formatted_price
    within(".album-quantity") do
      expect(page).to have_content "1"
    end

    click_link_or_button "+1"

    within(".cart-item") do
      expect(page).to have_content "2"
    end

    within(".cart-total") do
      expect(page).to have_content "Total: $2.00"
    end
  end

  scenario "they can adjust the quantity by subtracting" do
    album = FactoryGirl.create(:album)
    visit albums_path
    click_on "Add to cart"
    click_link "Cart"

    expect(page).to have_css("img[src*='#{album.image_url}']")
    expect(page).to have_content album.title
    expect(page).to have_content album.description
    expect(page).to have_content album.formatted_price
    within(".album-quantity") do
      expect(page).to have_content "1"
    end

    click_link_or_button "+1"
    click_link_or_button "+1"

    within(".album-quantity") do
      expect(page).to have_content "3"
    end

    click_link_or_button "-1"

    within(".album-quantity") do
      expect(page).to have_content "2"
    end
  end

  scenario "when quantity equals zero album disappears" do
    album = FactoryGirl.create(:album)
    visit albums_path
    click_on "Add to cart"
    click_link "Cart"

    expect(page).to have_css("img[src*='#{album.image_url}']")
    expect(page).to have_content album.title
    expect(page).to have_content album.description
    expect(page).to have_content album.formatted_price
    within(".album-quantity") do
      expect(page).to have_content "1"
    end

    click_link_or_button "-1"

    expect(page).to_not have_css("img[src*='#{album.image_url}']")
    expect(page).to_not have_content album.title
    expect(page).to_not have_content album.description
    expect(page).to_not have_content album.formatted_price
  end
end
