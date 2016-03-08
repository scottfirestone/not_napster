require "rails_helper"

RSpec.feature "Admin can create an album" do
  scenario "they see the album in the albums index" do
    admin = User.create(username: "administrator",
                        password: "password",
                        email:    "email@example.com",
                        role: 1
                       )

    Genre.create(name: "Jazz",       slug: "jazz")
    Genre.create(name: "Electronic", slug: "electronic")

    Artist.create(name: "Miles Davis", slug: "miles-davis")
    Artist.create(name: "Flying Lotus", slug: "flying-lotus")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on "Create New Album"

    expect(current_path).to eq("/admin/albums/new")

    fill_in "Title", with: "Kind of Blue"
    fill_in "Slug",  with: "kind-of-blue"
    find(".artistSelect").find(:xpath, '//option[contains(text(), "Miles Davis")]').select_option
    find(".genreSelect").find(:xpath, '//option[contains(text(), "Jazz")]').select_option
    fill_in "Description", with: "A must-have for any music collection"
    fill_in "Image url", with: "https://upload.wikimedia.org/wikipedia/en/9/9c/MilesDavisKindofBlue.jpg"
    fill_in "Release year", with: "1959"
    fill_in "Price", with: 7000

    click_on "Create Album"

    album = Album.last

    expect(current_path).to eq(album_path(album))
    expect(page).to have_content("#{album.title} has been created")
    expect(page).to have_css("img[src*='#{album.image_url}']")
    expect(page).to have_content(album.title)
    expect(page).to have_content(album.artist.name)
    expect(page).to have_content(album.formatted_price)
  end
end
