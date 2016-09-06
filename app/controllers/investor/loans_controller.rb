class Investor::LoansController < InvestorController
  before_action :authenticate_investor!
  before_action :set_companies, only: [:new, :create]

  def new
  end

  def create
    amount = params[:amount].to_i
    time = params[:time].to_i
    loan_amount = amount / @companies.count
    @companies.each do |c|
      l = Loan.create(company: c,
                   investor: current_investor,
                   amount: loan_amount,
                   time: time)
    end
    redirect_to investor_root_path
  end

  def destroy

  end

  private

  def set_companies
    @companies = Company.all
  end
end
