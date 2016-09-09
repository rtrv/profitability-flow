require 'rails_helper'

RSpec.describe Loan, type: :model do
  it 'has a company' do
    expect(FactoryGirl.build(:loan, company: nil)).to be_invalid
  end

  it 'has an investor' do
    expect(FactoryGirl.build(:loan, investor: nil)).to be_invalid
  end

  it 'is invalid without amount' do
    expect(FactoryGirl.build(:loan, amount: nil)).to be_invalid
  end

  it 'is invalid without time' do
    expect(FactoryGirl.build(:loan, time: nil)).to be_invalid
  end

  it 'is invalid if time is negative' do
    expect(FactoryGirl.build(:loan, time: -2)).to be_invalid
  end

  it 'is invalid if delay percent is less than regular' do
    expect(FactoryGirl.build(:loan,
                             regular_percent: 30,
                             delay_percent: 20)).to be_invalid
  end

  it 'should create payments' do
    expect(FactoryGirl.create(:loan, time: 2).payments.count).to eq(2)
  end
end
