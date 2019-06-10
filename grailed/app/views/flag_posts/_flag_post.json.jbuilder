json.extract! flag_post, :id, :post_id, :user_id, :reason, :created_at, :updated_at
json.url flag_post_url(flag_post, format: :json)
