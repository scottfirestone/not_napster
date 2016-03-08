require "rails_helper"

RSpec.feature "Admin can view albums" do
  scenario "they see the albums" do
    admin = User.create(username: "username",
                        password:  "password",
                        email:     "email@example.com",
                        role:      1
                       )

    albums = (0..3).map do
      FactoryGirl.create(:album)
    end

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    expect(page).to have_link("View Albums")

    click_on "View Albums"

    albums.each do |album|
      expect(page).to have_css("img[src*='#{album.image_url}']")
      expect(page).to have_link(album.title.to_s, album_path(album))
      expect(page).to have_content(album.description)
      expect(page).to have_content(album.title)
      expect(page).to have_content(album.artist.name)
      expect(page).to have_link("Edit", edit_admin_album_path(album))
    end
  end
end
