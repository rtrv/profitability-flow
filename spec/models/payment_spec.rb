require 'rails_helper'
require 'pp'

RSpec.describe Payment, type: :model do
  it 'is invalid without month' do
    expect(FactoryGirl.build(:payment, month: nil)).to be_invalid
  end

  it 'is invalid without loan' do
    expect(FactoryGirl.build(:payment, loan: nil)).to be_invalid
  end

  it 'should be a sequence' do
    payments = []
    loan = FactoryGirl.create(:loan)
    (1..6).each do |n|
      payments << FactoryGirl.create(:payment, loan: loan, month: n)
      pp payments
    end
    expect(payments.first.following).not_to be_nil
    expect(payments.first.previous).to be_nil
    expect(payments.last.following).to be_nil
    expect(payments.last.previous).not_to be_nil
  end

  # TODO: implement tests
  it 'can\'t be delayed after repayment'
  it 'can\'t be repayment twice'
  it 'can\'t be changed when it\'s paid'
end
