require "rails_helper"

RSpec.feature "Guest can view artist page" do
  scenario "they can see artist page" do
    artist = FactoryGirl.create(:artist_with_albums)

    visit artist_path(artist)

    artist.albums.each do |album|
      expect(page).to have_css("img[src*='#{album.image_url}']")
      expect(page).to have_content(album.title)
      expect(page).to have_content(album.formatted_price)
    end
  end
end
