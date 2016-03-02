require "rails_helper"

RSpec.feature "Guest can view all artists" do
  scenario "they see a list of all artists" do
    artist_1 = FactoryGirl.create(:artist)
    artist_2 = FactoryGirl.create(:artist)

    visit root_path
    click_link "Artists"

    expect(current_path).to eq(artists_path)
    expect(page).to have_content(artist_1.name)
    expect(page).to have_css("img[src*='#{artist_1.image_url}']")
    expect(page).to have_content(artist_2.name)
    expect(page).to have_css("img[src*='#{artist_2.image_url}']")
  end
end
