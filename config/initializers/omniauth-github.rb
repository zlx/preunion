Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :github, '49606f66f441df4f7931', 'baa2acb69c2a5a42076bb4438b4e8469d9a11995'
  elsif Rails.env.development?
    provider :github, 'aba3f4a733d0f57f8c54', 'eab0b789e692af442db20f6a7a2ee2ed2b9d49f2'
  end
end
