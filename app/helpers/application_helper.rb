module ApplicationHelper
  def login_logout_link(current_user)
    if current_user
      link_to "Logout", "#"
    else
      link_to "Login", "#"
    end
  end

  def username(current_user)
    if current_user
      "Logged in as #{current_user.username}"
    else
      "Guest"
    end
  end
end
