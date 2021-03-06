require 'test_helper'



class ProceedingTest < ActiveSupport::TestCase
  test "can sum data" do
    assert_difference "Proceeding.count",3  do
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
      Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
    end
    assert_equal 45.00, Proceeding.total
  end

  test "can count proceedings" do
    assert_difference "Proceeding.num_proceedings('all')",3  do
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
      Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
    end
  end


  test "can find amount spent in last month and previous month" do
    assert_difference "Proceeding.spent(0)", 45.00 do
      Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00), updated_at:Time.new(Time.now.year-15))
      Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
    end
    assert_difference "Proceeding.spent(1)", 45.00 do
      Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00), updated_at:Time.new(Time.now.year, Time.now.month-1))
    end
  end

  test "can count proceedings this month and last month" do
    assert_difference "Proceeding.num_proceedings(0)",3  do
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
      Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
    end
    assert_difference "Proceeding.num_proceedings(1)",1  do
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00), updated_at:Time.new(Time.now.year, Time.now.month-1))
    end
  end

  test "can find largest withdrawal ever and last month" do
    Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
    Proceeding.create(name:"turner",action:"Withdrawal",amount:(25000000000.00))
    Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
    Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00), updated_at:Time.new(Time.now.year, Time.now.month-1))
    assert_equal 25000000000.00, Proceeding.biggest_withdrawal("all")
    assert_equal 45.00, Proceeding.biggest_withdrawal(1)
  end

  test "can find greatest source of misery" do
    Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
    Proceeding.create(name:"rob",action:"Withdrawal",amount:(250.00))
    Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
    Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
    Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
    Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
    assert_equal "ROB", Proceeding.largest_moneysuck
    Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
    assert_equal "TURNER", Proceeding.largest_moneysuck 
  end



end
