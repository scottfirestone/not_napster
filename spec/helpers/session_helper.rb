module SessionHelper
  def log_in(user)
    visit root_path
    click_link "Login"
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_button "Login"
  end
end
