class Investor::PaymentsController < InvestorController
  before_action :authenticate_investor!

  def index
    @payments = current_investor.payments.order(updated_at: :desc)
  end
end
