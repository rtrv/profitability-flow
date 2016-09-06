class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  protect_from_forgery with: :exception

  before_action :set_current_account

  #@_current_user = session[:current_user]

  protected

  def not_authorized
    flash[:alert] = 'You are not authorized to perform this action'
    redirect_to(request.referrer || root_path)
  end

  def set_current_account
    if session[:current_account_id]
      @_current_account = Account.find(session[:current_account_id])
    end
  end
end
