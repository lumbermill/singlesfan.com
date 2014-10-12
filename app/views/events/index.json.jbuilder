json.array!(@events) do |event|
  json.extract! event, :id, :opendate, :opentime, :master_id, :title, :short_desc, :long_desc, :url, :submaster_id, :posted_by
  json.url event_url(event, format: :json)
end
