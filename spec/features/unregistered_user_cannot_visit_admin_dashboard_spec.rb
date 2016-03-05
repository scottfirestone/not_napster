require "rails_helper"

RSpec.feature "Unregistered user cannot visit admin dashboard" do
  scenario "they get a 404" do
    visit admin_dashboard_path

    expect(page).to have_content("doesn't exist (404)")
  end
end
