module ApplicationHelper
  def destroy_session_link
    if current_company
      destroy_company_session_path
    elsif current_investor
      destroy_investor_session_path
    end
  end

  def dashboard_path
    if current_company
      company_root_path
    elsif current_investor
      investor_root_path
    end
  end
end
