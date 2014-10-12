json.array!(@masters) do |master|
  json.extract! master, :id, :name, :email, :password_digest, :active, :picture, :desc
  json.url master_url(master, format: :json)
end
