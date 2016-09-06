class Companies::SessionsController < Devise::SessionsController
  # GET /companies/sign_in
  def new
    current_investor ? (redirect_to root_path) : super
  end

  def create
    super
    session[:current_account_id] = current_company.id
  end

  def destroy
    super
    session[:current_account_id] = nil
  end
end
