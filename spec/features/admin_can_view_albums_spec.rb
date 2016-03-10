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

    expired_album = FactoryGirl.create(:album)

    expired_album.update(expiry_date: (Time.now - 7.months))

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
      expect(page).to have_content(album.status)
      expect(page).to have_link("Edit", edit_admin_album_path(album))
    end

    expect(page).to have_css("img[src*='#{expired_album.image_url}']")
    expect(page).to have_link(expired_album.title.to_s, album_path(expired_album))
    expect(page).to have_content(expired_album.description)
    expect(page).to have_content(expired_album.title)
    expect(page).to have_content(expired_album.artist.name)
    expect(page).to have_content(expired_album.status)
    expect(page).to have_link("Edit", edit_admin_album_path(expired_album))
  end
end
