require 'test_helper'

class AccessAccountsControllerTest < ActionController::TestCase
  setup do
    @access_account = access_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:access_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create access_account" do
    assert_difference('AccessAccount.count') do
      post :create, access_account: { amount: @access_account.amount, name: @access_account.name }
    end

    assert_redirected_to access_account_path(assigns(:access_account))
  end

  test "should show access_account" do
    get :show, id: @access_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @access_account
    assert_response :success
  end

  test "should update access_account" do
    patch :update, id: @access_account, access_account: { amount: @access_account.amount, name: @access_account.name }
    assert_redirected_to access_account_path(assigns(:access_account))
  end

  test "should destroy access_account" do
    assert_difference('AccessAccount.count', -1) do
      delete :destroy, id: @access_account
    end

    assert_redirected_to access_accounts_path
  end
end
