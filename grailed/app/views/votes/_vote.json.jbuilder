json.extract! vote, :id, :user_id, :post, :created_at, :updated_at
json.url vote_url(vote, format: :json)
