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
end
