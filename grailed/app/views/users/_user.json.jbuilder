json.extract! user, :id, :email, :password, :picture, :bio, :city, :country, :role, :created_at, :updated_at
json.url user_url(user, format: :json)
