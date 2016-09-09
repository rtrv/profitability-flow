class HomeController < ApplicationController

  TIME = 6

  def index
    flash[:error] = nil

    @expected_profit = 30
    @actual_profit = Loan.actual_profit

    @expected_payment = nil
    @actual_payment = nil

    amount = params[:amount]
    unless amount.blank?
      if amount.match(/^\d+(.\d+)?$/) && amount.to_f != 0
        @expected_payment = amount.to_f * (@expected_profit / 100.0) * TIME / 12
        @actual_payment = amount.to_f * (@actual_profit / 100.0) * TIME / 12
      else
        flash[:error] = 'Некорректная сумма'
      end
    end
  end
end
