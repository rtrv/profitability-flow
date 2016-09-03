class Company::DashboardController < ApplicationController
  before_action :authenticate_company!

  def index
  end
end
