class Investor::RegistrationsController < Devise::RegistrationsController
  # GET /investors/sign_up
  def new
    current_company ? (redirect_to root_path) : super
  end
end
