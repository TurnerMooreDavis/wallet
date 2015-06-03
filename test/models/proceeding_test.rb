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
      Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00), created_at:Time.new(2000))
      Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
    end
    assert_difference "Proceeding.spent(1)", 45.00 do
      Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00), created_at:Time.new(2015, 5))
    end
  end

  test "can count proceedings this month and last month" do
    assert_difference "Proceeding.num_proceedings(0)",3  do
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
      Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
    end
    assert_difference "Proceeding.num_proceedings(1)",1  do
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00), created_at:Time.new(2015, 5))
    end
  end


end
