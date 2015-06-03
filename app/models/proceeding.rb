class Proceeding < ActiveRecord::Base
  def self.total
    total = 0
    self.all.each do |p|
      if p.action == "Deposit"
        total += p.amount
      elsif p.action == "Withdrawal"
        total -= p.amount
      else
        blow up
      end
    end
    return total
  end
end
