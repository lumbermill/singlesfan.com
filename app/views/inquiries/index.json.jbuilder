json.array!(@inquiries) do |inquiry|
  json.extract! inquiry, :id, :name, :email, :date, :memo
  json.url inquiry_url(inquiry, format: :json)
end
