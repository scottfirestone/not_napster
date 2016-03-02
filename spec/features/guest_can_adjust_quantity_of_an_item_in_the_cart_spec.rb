require "rails_helper"

RSpec.feature "Guest can adjust quantity of an item in the cart" do
  scenario "they can adjust the quantity" do
    album = FactoryGirl.create(:album)

    visit albums_path
    click_on "Add to cart"
    click_link "Cart"

    expect(page).to have_css("img[src*='#{album.image_url}']")
    expect(page).to have_content album.title
    expect(page).to have_content album.description
    expect(page).to have_content album.formatted_price
    within("#cart_quantity") do
      expect(page).to have_content "1"
    end

    click_link_or_button "Plus"

    within("#cart_quantity") do
      expect(page).to have_content "2"
    end

    click_on "Update"
    within(".total-price") do
      expect(page).to_not have_content "Total: $2.02"
    end
  end
end

#make a minus one
# Background: My cart has an item in it
#       As a visitor
#       When I visit "/cart"
#       Then I should see my item with a quantity of 1
#       And when I increase the quantity
#       Then my current page should be '/cart'
#       And that item's quantity should reflect the increase
#       And the subtotal for that item should increase
#       And the total for the cart should match that increase
#       And when I decrease the quantity
#       Then my current page should be '/cart'
#       And that item's quantity should reflect the decrease
#       And the subtotal for that item should decrease
#       And the total for the cart should match that decrease
