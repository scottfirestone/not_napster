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
end
