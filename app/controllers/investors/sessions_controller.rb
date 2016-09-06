class Investors::SessionsController < Devise::SessionsController
  # GET /investor/sign_in
  def new
    current_company ? (redirect_to root_path) : super
  end

  def create
    super
    session[:current_account_id] = current_investor.id
  end

  def destroy
    super
    session[:current_account_id] = nil
  end
end
