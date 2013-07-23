Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :github, '49606f66f441df4f7931', 'baa2acb69c2a5a42076bb4438b4e8469d9a11995'
  elsif Rails.env.development?
    provider :github, 'ede8c008b96247d0336b', '34cffe39db5f76f7fadcd71692454acebf1a7d25'
  end
end
