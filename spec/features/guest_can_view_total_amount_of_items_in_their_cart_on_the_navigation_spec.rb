require "rails_helper"

RSpec.feature "Guest sees total amount of items in their cart on the navbar" do
  scenario "guest can see total items on navbar" do
    FactoryGirl.create(:album)

    visit albums_path

    click_on "Add to cart"
    click_on "Add to cart"
    click_on "Add to cart"

    within(".site-nav") do
      expect(page).to have_content "3"
    end
  end

  scenario "if total items is zero, it won't display on navigation" do
    visit root_path

    within(".site-nav") do
      expect(page).to_not have_content "0"
    end
  end
end
