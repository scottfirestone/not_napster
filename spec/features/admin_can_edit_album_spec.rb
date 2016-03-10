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
    new_image = "https://upload.wikimedia.org/wikipedia/en/9/9c/MilesDavisKindofBlue.jpg"
    new_title = "Updated Album Title"
    new_slug  = "updated-album-title"
    new_description = "A must-have for any music collection"
    new_release_year = "1959"
    new_price = 7000

    visit admin_albums_path
    click_on "Edit"

    expect(current_path).to eq("/admin/albums/#{album.slug}/edit")

    fill_in "Title", with: new_title
    fill_in "Slug",  with: new_slug
    find(".artistSelect").find(:xpath, '//option[contains(text(), "Artist")]').select_option
    find(".genreSelect").find(:xpath, '//option[contains(text(), "Musak")]').select_option
    fill_in "Description", with: new_description
    fill_in "Image url", with: new_image
    fill_in "Release year", with: new_release_year
    fill_in "Price", with: new_price
    click_on "Edit Album"

    expect(current_path).to eq(admin_albums_path)

    expect(page).to have_css("img[src*='#{new_image}']")
    expect(page).to have_link(new_title, album_path(album))
    expect(page).to have_content(new_description)
    expect(page).to have_link("Edit", edit_admin_album_path(album))
  end
end
