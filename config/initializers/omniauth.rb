Rails.application.config.middleware.use OmniAuth::Builder do
  provider :discord, ENV['DISCORD_APPID'], ENV['DISCORD_SECRET']
end
OmniAuth.config.failure_raise_out_environments = []