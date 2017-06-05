json.array!(@microquestion) do |microquestion|
  json.extract! microquestion, :id, :content, :user_id
  json.url microquestion_url(microquestion, format: :json)
end
