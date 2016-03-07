require "rails_helper"

RSpec.feature "Admin cannot create invalid album" do
  scenario "they see the create album page" do
    admin = User.create(username: "administrator",
                        password: "password",
                        email:    "example@email.com",
                        role:     1
                       )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    album = FactoryGirl.create(:album)
    Genre.create(name: "Jazz", slug: "jazz")

    expect(album.id).to eq(2)

    visit new_admin_album_path

    fill_in "Title", with: album.title
    fill_in "Slug",  with: album.slug
    find(".artistSelect").find(:xpath, "//option[contains(text(), 'Artist 1')]").select_option
    find(".genreSelect").find(:xpath, "//option[contains(text(), 'Jazz')]").select_option
    fill_in "Description", with: "A must-have for any music collection"
    fill_in "Image url", with: "https://upload.wikimedia.org/wikipedia/en/9/9c/MilesDavisKindofBlue.jpg"
    fill_in "Release year", with: "1959"
    fill_in "Price", with: 7000

    click_on "Create Album"

    expect(page).to_not have_content("#{album.title} has been created")
    expect(page).to have_content("Invalid Entry")
    expect(album.id).to eq(2)
  end
end
