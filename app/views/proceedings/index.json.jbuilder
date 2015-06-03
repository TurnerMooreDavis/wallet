json.array!(@proceedings) do |proceeding|
  json.extract! proceeding, :id, :name, :amount, :action
  json.url proceeding_url(proceeding, format: :json)
end
