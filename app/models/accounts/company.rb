class Company < Account
  has_many :loans
  has_many :payments, through: :loans
end
