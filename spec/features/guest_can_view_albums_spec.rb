require "rails_helper"

RSpec.feature "Guest can view all albums" do
  scenario "they see all the albums" do
    2.times { FactoryGirl.create(:album) }

    visit albums_path

    within(".albums") do
      expect(page).to have_content("Title 1")
      expect(page).to have_content("$1.00")
      expect(page).to have_content("Title 1")
      expect(page).to have_content("$1.01")
    end
  end
end
