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

  def self.num_proceedings
    self.count
  end

  def self.spent
    total = 0
    self.all.each do |p|
      if p.action == "Withdrawal" && (Time.now - p.created_at < 31535000)
        total += p.amount
      end
    end
    return total.to_f
  end

end
