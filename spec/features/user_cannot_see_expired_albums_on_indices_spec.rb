require "rails_helper"

RSpec.feature "User cannot see expired albums on indicies" do
  scenario "the expired album does not appear on albums index" do
    album = FactoryGirl.create(:album)
    album.update(expiry_date: (Time.now - 7.months))

    user = User.create(username: "scottrick",
                       password: "password",
                       email: "email@email.com"
                      )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit albums_path

    within(".section-container .clearfix") do
      expect(page).to_not have_content(album.title)
      expect(page).to_not have_content(album.artist.name)
      expect(page).to_not have_content("Add to cart")
    end
  end

  scenario "the expired album does not appear on genre albums index" do
    album = FactoryGirl.create(:album)
    genre = FactoryGirl.create(:genre)
    album.update(expiry_date: (Time.now - 7.months), genre_id: genre.id)

    user = User.create(username: "scottrick",
                       password: "password",
                       email: "email@email.com"
                      )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit genre_path(album.genre)

    within(".section-container") do
      expect(page).to_not have_content(album.title)
      expect(page).to_not have_content(album.artist.name)
      expect(page).to_not have_content("Add to cart")
    end
  end

  scenario "expired albums do not appear on the artist page" do
    album = FactoryGirl.create(:album)
    genre = FactoryGirl.create(:genre)
    user = User.create(username: "scottrick",
                       password: "password",
                       email: "email@email.com"
                      )

    album.update(expiry_date: (Time.now - 7.months), genre_id: genre.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit artist_path(album.artist)

    within(".section-container") do
      expect(page).to_not have_content(album.title)
      expect(page).to_not have_content(album.artist.name)
      expect(page).to_not have_content("Add to cart")
    end
  end
end
