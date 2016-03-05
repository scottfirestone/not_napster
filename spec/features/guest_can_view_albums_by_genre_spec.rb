require "rails_helper"

RSpec.feature "Guest can view albums by genre" do
  scenario "they see albums by genre" do
    album_1, album_2, album_3, album_4 = (0..3).map do
      FactoryGirl.create(:album)
    end

    genre_1, genre_2 = (0..1).map { FactoryGirl.create(:genre) }
    genre_1.albums << [album_1, album_2]
    genre_2.albums << [album_3, album_4]

    visit genre_path(album_1.genre)

    expect(page).to have_content("Musak")
    expect(page).to have_content(album_1.title)
    expect(page).to have_content(album_2.title)
    expect(page).to_not have_content(album_3.title)
    expect(page).to_not have_content(album_4.title)
  end
end
