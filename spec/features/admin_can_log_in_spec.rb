require "rails_helper"

RSpec.feature "Admin can log in" do
  scenario "they see the admin dashboard" do
    admin = User.create(username: "administrator",
                        password: "password",
                        email: "user@example.com",
                        role: 1
                       )

    visit root_path
    click_on "Login"

    fill_in "Username", with: admin.username
    fill_in "Password", with: admin.password
    click_button "Login"

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Admin Dashboard")
  end
end
