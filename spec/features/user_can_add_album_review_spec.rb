require "rails_helper"

RSpec.feature "a user can leave an album review" do
  scenario "user reviews one album" do
    album = FactoryGirl.create(:album)
    user = User.create(username: "scottrick",
                       password: "password",
                       email: "email@email.com"
                      )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit album_path(album)

    fill_in "Comment", with: "This was terrible."
    click_on "Create Review"
    expect(current_path).to eq(album_path(album))
    expect(page).to have_content "This was terrible."
  end
end
