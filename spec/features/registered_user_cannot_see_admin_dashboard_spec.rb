require "rails_helper"

RSpec.feature "Registered user cannot see admin dashboard" do
  scenario "they get a 404" do
    user = User.create(username: "scottrick",
                       password: "password",
                       email: "email@email.com"
                      )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path

    expect(page).to have_content("doesn't exist (404)")
    expect(page).to_not have_content("Admin Dashboard")
  end
end
