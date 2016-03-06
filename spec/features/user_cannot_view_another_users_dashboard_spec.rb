require "rails_helper"

RSpec.feature "User cannot view another users dashboard" do
  scenario "they are redirected to their dashboard" do
    current_user = FactoryGirl.create(:user)
    forbidden_user = FactoryGirl.create(:user)
    log_in(current_user)

    visit dashboard_path(forbidden_user.id)

    expect(page).to have_content(current_user.username)
    expect(page).to have_content(current_user.email)
    expect(page).to_not have_content(forbidden_user.username)
    expect(page).to_not have_content(forbidden_user.email)
  end
end
