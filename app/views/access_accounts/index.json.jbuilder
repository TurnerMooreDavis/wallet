json.array!(@access_accounts) do |access_account|
  json.extract! access_account, :id, :name, :amount
  json.url access_account_url(access_account, format: :json)
end
