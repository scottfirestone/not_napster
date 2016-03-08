  require "rails_helper"

RSpec.feature "Admin cannot create invalid album" do
  scenario "existing slug returns to the album create page with an error msg" do
    admin = User.create(username: "administrator",
                        password: "password",
                        email: "admin@email.com",
                        role: 1
                       )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    genre = Genre.create(name: "Jazz", slug: "jazz")
    album = FactoryGirl.create(:album)
    album.update(genre_id: genre.id)

    visit new_admin_album_path

    fill_in "Title", with: "New Title"
    fill_in "Slug",  with: album.slug
    find(".artistSelect").find(:xpath, '//option[contains(text(), "Artist")]').select_option
    find(".genreSelect").find(:xpath, '//option[contains(text(), "Jazz")]').select_option
    fill_in "Description", with: "A must-have for any music collection"
    fill_in "Image url", with: "https://upload.wikimedia.org/wikipedia/en/9/9c/MilesDavisKindofBlue.jpg"
    fill_in "Release year", with: "1959"
    fill_in "Price", with: 7000

    click_on "Create Album"

    last_album = Album.last

    expect(last_album.title).to_not eq("New Title")
    expect(page).to have_content("Invalid Entry")
  end

  scenario "existing artist/title combo returns to the album create page with an error msg" do
    admin = User.create(username: "administrator",
                        password: "password",
                        email: "admin@email.com",
                        role: 1
                       )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    genre = Genre.create(name: "Jazz", slug: "jazz")
    album = FactoryGirl.create(:album)
    album.update(genre_id: genre.id)

    visit new_admin_album_path

    fill_in "Title", with: album.title
    fill_in "Slug",  with: "New Slug"
    find(".artistSelect").find(:xpath, '//option[contains(text(), "Artist")]').select_option
    find(".genreSelect").find(:xpath, '//option[contains(text(), "Jazz")]').select_option
    fill_in "Description", with: "A must-have for any music collection"
    fill_in "Image url", with: "https://upload.wikimedia.org/wikipedia/en/9/9c/MilesDavisKindofBlue.jpg"
    fill_in "Release year", with: "1959"
    fill_in "Price", with: 7000

    click_on "Create Album"

    last_album = Album.last

    expect(last_album.slug).to_not eq("New Slug")
    expect(page).to have_content("Invalid Entry")
  end
end
