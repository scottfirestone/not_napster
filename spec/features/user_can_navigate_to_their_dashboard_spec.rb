require "rails_helper"

RSpec.feature "User can navigate to their dashboard" do
  scenario "they are on their dashboard and see their info" do
    user = FactoryGirl.create(:user)
    log_in(user)

    visit root_path
    click_link user.username

    expect(page).to have_content(user.username)
    expect(page).to have_content(user.email)
  end
end
