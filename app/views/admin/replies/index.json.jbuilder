json.array!(@replies) do |reply|
  json.extract! reply, :id, :name
  json.url reply_url(reply, format: :json)
end
