require "rails_helper"

RSpec.feature "User can edit their account info" do
  scenario "user can edit their username and email" do
    user = User.create(username: "salvi6god",
                       password: "password",
                       email: "email@email.com"
                      )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_link  "Update Account"
    expect(current_path).to eq(user_edit_path)
    expect(page).to have_content("Update Account")

    fill_in "Username", with: "salviog"
    fill_in "Email", with: "alex@email.com"

    click_link_or_button "Update Account"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Account updated!")
    expect(page).to have_content("Update Account")
    expect(page).to have_content("Username: salviog")
    expect(page).to have_content("Email: alex@email.com")
  end

  context "with invalid information" do
    scenario "they see an error message" do
      user = User.create(username: "salvi6god",
                         password: "password",
                         email: "email@email.com"
                        )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
      click_link "Update Account"
      expect(current_path).to eq(user_edit_path)
      expect(page).to have_content("Update Account")

      fill_in "Username", with: ""
      fill_in "Email", with: user.email

      click_link_or_button "Update Account"

      expect(page).to_not have_content("Account updated!")

      within(".errors") do
        expect(page).to have_content("Invalid entry")
      end
    end
  end
end
