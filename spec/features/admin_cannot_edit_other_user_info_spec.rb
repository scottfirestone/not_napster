require "rails_helper"

RSpec.feature "Admin cannot edit other user info" do
  scenario "they get redirected to the admin dashboard" do
    admin = User.create(username: "administrator",
                        password: "password",
                        email: "admin@email.com",
                        role: 1
                       )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit dashboard_path

    expect(current_path).to eq(admin_dashboard_path)
  end
end
