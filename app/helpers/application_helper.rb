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

  def active_link(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def print_money(amount)
    ('%.2f' % amount) + ' р.' if amount
  end

  def print_percent(percent)
    percent.round.to_s + ' %'
  end
end
