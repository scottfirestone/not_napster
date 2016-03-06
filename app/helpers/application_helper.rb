module ApplicationHelper
  def login_logout_link(current_user)
    if current_user
      link_to "Logout", logout_path, method: :delete
    else
      link_to "Login", login_path
    end
  end

  def username(current_user)
    if current_user
      link_to current_user.username, dashboard_path
    else
      "Guest"
    end
  end
end
