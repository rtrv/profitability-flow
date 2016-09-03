class Investor::DashboardController < ApplicationController
  before_action :authenticate_investor!

  def index
  end
end
