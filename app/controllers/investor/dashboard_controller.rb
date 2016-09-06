class Investor::DashboardController < InvestorController
  before_action :authenticate_investor!

  def index
    @loans = Loan.where(investor: current_investor)
  end
end
