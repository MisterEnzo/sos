module ApplicationHelper
  def login_helper
    if current_user
      (link_to "User Profile", "#") + 
      (link_to "Logout", destroy_user_session_path, method: :delete)
    else
      (link_to "Login", new_user_session_path, class: "btn btn-primary") +
      (link_to "Signup", new_user_registration_path, class: "btn btn-outline-primary")
    end
  end

  def copyright_generator
    EnzViewTool::Renderer.copyright "Enzo Naguiat", "All Rights Reserved"
  end

end
