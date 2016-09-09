class Payment < ApplicationRecord
  belongs_to :loan

  validates_presence_of :month, :loan

  before_validation :set_actual_amount, if: ->(obj) { obj.paid }
  after_save :freeze_paid, if: ->(obj) { obj.paid }
  after_save :close_following_from_repayment, if: ->(obj) { obj.repayment }

  SEQUENCE_METHODS = [:following, :previous].freeze

  scope :unpaid, -> { where('paid = false or paid is null') }

  def following
    loan.payments.find_by(month: month + 1)
  end

  def previous
    loan.payments.find_by(month: month - 1)
  end

  SEQUENCE_METHODS.each do |method|
    define_method("all_#{method}") do
      a = []
      step = send(method)
      while step
        a << step
        step = step.send(method)
      end
      a
    end
  end

  def first?
    previous.nil?
  end

  def last?
    following.nil?
  end

  def state
    state = 'Статус неизвестен'
    if paid
      if actual_amount == 0
        state = 'Займ был погашен ранее'
      elsif repayment
        state = 'Досрочное погашение займа'
        state << ' c задержкой последнего платежа' if delayed
      else
        state = 'Выплата произведена'
        state << ' с задержкой' if delayed
      end
    else
      state = 'Выплата не произведена'
    end
    state
  end

  private

  def set_actual_amount
    if previous&.repayment || previous&.actual_amount == 0
      self.actual_amount = 0
    else
      self.actual_amount = self.expected_amount
      if self.repayment
        all_following.count.times do
          self.actual_amount = self.actual_amount + loan.monthly_by_debt
        end
      end
    end
    if self.delayed
      self.actual_amount = self.actual_amount + loan.delayed_penalty
    end
  end

  def freeze_paid
    readonly!
  end

  def close_following_from_repayment
    all_following.each do |p|
      p.paid = true
      p.save
    end
  end
end
