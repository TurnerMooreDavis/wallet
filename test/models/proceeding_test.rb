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
    assert_difference "Proceeding.num_proceedings",3  do
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
      Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
      Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
    end
  end

  test "can find amount spent in last year" do
    Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00), created_at:Time.new(2000))
    Proceeding.create(name:"turner",action:"Withdrawal",amount:(45.00))
    Proceeding.create(name:"turner",action:"Deposit",amount:(45.00))
    assert_equal 54.99, Proceeding.spent
  end
end
