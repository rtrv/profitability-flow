class Companies::RegistrationsController < Devise::RegistrationsController
  # GET /companies/sign_up
  def new
    current_investor ? (redirect_to root_path) : super
  end
end
