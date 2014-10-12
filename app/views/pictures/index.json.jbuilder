json.array!(@pictures) do |picture|
  json.extract! picture, :id, :origin, :thumb, :desc, :active, :posted_by
  json.url picture_url(picture, format: :json)
end
