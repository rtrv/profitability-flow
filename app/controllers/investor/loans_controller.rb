class Investor::LoansController < InvestorController
  before_action :authenticate_investor!
  before_action :set_companies, only: [:new, :create]

  def new
  end

=begin
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
=end

  def create
    amount = params[:amount].to_f
    time = params[:time].to_i
    company = Company.find(params[:company_id].to_i)
    Loan.create(company: company,
                investor: current_investor,
                amount: amount,
                time: time)
    redirect_to investor_root_path
  end

  #def destroy
  #end

  private

  def set_companies
    @companies = Company.all
  end
end
