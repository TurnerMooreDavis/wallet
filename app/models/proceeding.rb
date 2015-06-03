require "set"
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

  def self.num_proceedings(offset)
    if offset == "all"
      return self.count
    else
      total = 0
      self.all.each do |p|
        if (Time.now.month-offset == p.updated_at.month)
          total += 1
        end
      end
      return total
    end
  end

  def self.biggest_withdrawal(offset)
    greatest = 0
    self.all.each do |p|
      if p.amount > greatest && p.action == "Withdrawal" && offset == "all"
        greatest = p.amount
      elsif p.amount > greatest && p.action == "Withdrawal" && (Time.now.month-offset == p.updated_at.month)
        greatest = p.amount
      end
    end
    return greatest.to_f
  end


  def self.spent(offset)
    total = 0
    self.all.each do |p|
      if p.action == "Withdrawal" && (Time.now.month-offset == p.updated_at.month)
        total += p.amount
      end
    end
    return total.to_f
  end

  def self.largest_moneysuck
    names_and_amounts = {}
    self.all.each do |p|
      if names_and_amounts.has_key?(p.name.upcase) && p.action == "Withdrawal"
        amount = (names_and_amounts.fetch("#{p.name.upcase}") + p.amount)
        names_and_amounts.store(p.name.upcase, amount.to_f)
      elsif p.action == "Withdrawal"
        names_and_amounts.store(p.name.upcase, p.amount.to_f)
      end
    end
    result=names_and_amounts.max_by{|n| n[1]}
    return result[0]
  end


end
