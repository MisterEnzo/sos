module ApplicationHelper
  def login_helper
    if current_user
      (tag.li(link_to "User Profile", "#")) + 
      (tag.li(link_to "Logout", destroy_user_session_path, method: :delete))
    else
      (tag.li(link_to "Login", new_user_session_path)) +
      (tag.li(link_to "Signup", new_user_registration_path))
    end
  end
end
