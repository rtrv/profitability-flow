FactoryGirl.define do
  factory :payment do |f|
    loan
    f.sequence(:month) { |n| n.to_i }
    f.delayed false
    f.repayment false
    f.paid true
  end
end
