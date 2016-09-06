Company.new(name: 'Start Industries',
            description: 'Высокотехнологическое оружие, атомная энергетика',
            email: 'tony@stark.ind',
            password: 'avengers rule').save
Company.new(name: 'Wayne Enterprises',
            description: 'Недвижимость, научные исследования',
            email: 'bruce@way.ne',
            password: 'martha').save
Company.new(name: 'Umbrella Corporation',
            description: 'Фармацевтика',
            email: 'contact@umbrella.com',
            password: 'mother').save

Investor.new(name: 'Бенджамин Вестор',
             email: 'investor@fl.ow',
             password: '123456').save

Company.all.each do |c|
  Loan.new(company: c,
           investor: Investor.first,
           amount: 1_000_000,
           time: 6,
           regular_percent: 30,
           delay_percent: 50).save
end

Loan.first.payments.each do |p|
  p.delayed = false
  p.repayment = false
  p.paid = true
  p.save
end

Loan.second.payments.each.with_index do |p, i|
  p.delayed = false
  p.repayment = i == 3 ? true : false
  p.paid = true
  p.save
  break if p.repayment
end

Loan.third.payments.each.with_index do |p, i|
  p.delayed = i < 2 ? false : true
  p.repayment = false
  p.paid = true
  p.save
end
