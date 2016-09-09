class Company::DashboardController < ApplicationController
  before_action :authenticate_company!

  def index
    @loans = Loan.where(company: current_company)
  end
end
