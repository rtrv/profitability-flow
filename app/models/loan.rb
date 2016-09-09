class Loan < ApplicationRecord
  belongs_to :company
  belongs_to :investor

  has_many :payments, dependent: :destroy

  validates_presence_of :company, :investor, :amount, :time,
                        :regular_percent, :delay_percent
  validates :time, numericality: { greater_than: 0, less_than: 120 }
  validates :amount, numericality: { greater_than: 0 }
  validates :delay_percent,
            numericality: { greater_than: :regular_percent }

  after_create :create_payments
  before_validation :default_values

  def monthly_by_debt
    amount / time
  end

  def monthly_by_percent
    (amount / time) * (regular_percent / 100.0) * (time / 12.0)
  end

  def monthly_payment
    monthly_by_debt + monthly_by_percent
  end

  def delayed_penalty
    amount * ((delay_percent - regular_percent) / 100.0 * (time / 12.0)) / time
  end

  def expected_profit
    regular_percent
  end

  def actual_amount
    payments.map { |p| p.actual_amount }.reduce(0, :+)
  end

  def profit_by_percent
    actual_amount - amount
  end

  def actual_profit
    if payments.unpaid.count > 0
      false
    else
      # All payments are paid
      (profit_by_percent / amount * 12 / time * 100).round
    end
  end

  def following_payment
    if payments.unpaid.count == 0
      nil
    else
      payments.unpaid.first
    end
  end

  def self.actual_profit
    loans = []
    Loan.all.each do |l|
      loans << l.actual_profit if l.actual_profit
    end
    loans.inject { |a, e| a + e }.to_f / loans.size
  end

  def state
    if payments.unpaid.count == 0
      'Полностью погашен'
    else
      'Оставшиеся платежи: ' + payments.unpaid.count.to_s
    end
  end

  private

  def create_payments
    for i in 1..time
      payments.create(month: i, expected_amount: monthly_payment)
    end
  end

  def default_values
    self.time ||= 6
    self.regular_percent ||= 30
    self.delay_percent ||= 50
  end
end
