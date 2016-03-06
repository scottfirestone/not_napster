require "rails_helper"

RSpec.feature "Admin can see admin dashboard" do
  scenario "they can see the items index with CRUD links" do
    admin = User.create(username: "administrator",
                        password: "password",
                        email: "admin@email.com",
                        role: 1
                       )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    expect(page).to have_content("Admin Dashboard")
  end
end
