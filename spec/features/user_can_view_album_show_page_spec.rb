require "rails_helper"

RSpec.feature "User can view album show page" do
  scenario "they see the album and its information" do
    album = FactoryGirl.create(:album)

    visit albums_path
    within(".preview") do
      click_link album.title
    end

    expect(current_path).to eq(album_path(album))
    expect(page).to have_content(album.title)
    expect(page).to have_content(album.artist.name)
    expect(page).to have_button("Add to cart")
  end
end
