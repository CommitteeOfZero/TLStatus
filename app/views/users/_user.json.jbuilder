json.extract! user, :id, :name, :discord_uid, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)
