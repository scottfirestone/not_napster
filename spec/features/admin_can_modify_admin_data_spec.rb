require "rails_helper"

RSpec.feature "Admin can modify admin info" do
  scenario "they see the modified info" do
    admin = User.create(username: "administrator",
                        password: "password",
                        email: "user@example.com",
                        role: 1
                       )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_on "Edit Account"

    expect(page).to have_selector("input[value='#{admin.username}']")
    expect(page).to have_selector("input[value='#{admin.email}']")

    fill_in "Username", with: "New Username"
    fill_in "Email",    with: "new_email@example.com"

    click_on "Update Account"

    expect(page).to have_content("New Username")
    expect(page).to_not have_content("administrator")

    expect(page).to have_content("new_email@example.com")
    expect(page).to_not have_content("user@example.com")
  end
end
