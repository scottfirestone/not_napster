require "rails_helper"

RSpec.feature "Guest can view all albums" do
  scenario "they see all the albums" do
    album_1 = FactoryGirl.create(:album)
    album_2 = FactoryGirl.create(:album)

    visit albums_path

    expect(page).to have_content(album_1.title)
    expect(page).to have_content(album_1.formatted_price)
    expect(page).to have_content(album_2.title)
    expect(page).to have_content(album_2.formatted_price)
  end
end
