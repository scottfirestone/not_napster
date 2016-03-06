require "rails_helper"

RSpec.feature "User can view an artist page" do
  scenario "they see all albums associated with artist" do
    artist = Artist.create(name: "Miles Davis", slug: "miles-davis")
    album_1 = artist.albums.create(
      title: "Bitches Brew",
      description: "An album by Miles Davis",
      image_url: "https://upload.wikimedia.org/wikipedia/en/thumb/7/72/Bitches_brew.jpg/220px-Bitches_brew.jpg",
      release_year: 1970,
      price: 1500
    )
    album_2 = artist.albums.create(
      title: "Kind of Blue",
      description: "Another album by Miles Daivs",
      image_url: "https://upload.wikimedia.org/wikipedia/en/9/9c/MilesDavisKindofBlue.jpg",
      release_year: 1959,
      price: 1700
    )

    visit albums_path
    click_link "Miles Davis", match: :first

    expect(current_path).to eq("/artists/miles-davis")
    expect(page).to have_content("Miles Davis")
    expect(page).to have_content(album_1.title)
    expect(page).to have_content(album_2.title)
  end
end
