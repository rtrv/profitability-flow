FactoryGirl.define do
  factory :loan do |f|
    id 1
    company
    investor
    f.amount 100_000
    f.time 6
    f.regular_percent 30
    f.delay_percent 50
    initialize_with { Loan.find_or_create_by(id: id) }
  end
end
