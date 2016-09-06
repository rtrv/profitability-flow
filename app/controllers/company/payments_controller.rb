class Company::PaymentsController < ApplicationController
  before_action :authenticate_company!

  # TODO: write normal controller
  def update
    @payment = Payment.find(params[:id])
    @payment.delayed = params[:delayed]
    @payment.repayment = params[:repayment]
    @payment.paid = true
    @payment.save

    redirect_to company_root_path
  end
end
