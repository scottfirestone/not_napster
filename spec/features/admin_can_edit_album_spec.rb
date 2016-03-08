require "rails_helper"

RSpec.feature "Admin can edit an album" do
  scenario "they see the new album info" do
    admin = User.create(username: "administrator",
                        password:  "password",
                        email:     "email@example.com",
                        role:      1
                       )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    album = FactoryGirl.create(:album)
    FactoryGirl.create(:genre)

    visit admin_albums_path

    click_on "Edit"

    expect(current_path).to eq("/admin/albums/#{album.slug}/edit")

    fill_in "Title", with: "Updated Album Title"
    fill_in "Slug",  with: "updated-album-title"
    find(".artistSelect").find(:xpath, '//option[contains(text(), "Artist")]').select_option
    find(".genreSelect").find(:xpath, '//option[contains(text(), "Musak")]').select_option
    fill_in "Description", with: "A must-have for any music collection"
    fill_in "Image url", with: "https://upload.wikimedia.org/wikipedia/en/9/9c/MilesDavisKindofBlue.jpg"
    fill_in "Release year", with: "1959"
    fill_in "Price", with: 7000

    click_on "Edit Album"

    expect(current_path).to eq(admin_albums_path)

    expect(page).to have_css("img[src*='#{album.image_url}']")
    expect(page).to have_link(album.title.to_s, album_path(album))
    expect(page).to have_content(album.description)
    expect(page).to have_content(album.title)
    expect(page).to have_content(album.artist.name)
    expect(page).to have_link("Edit", edit_admin_album_path(album))
  end
end
