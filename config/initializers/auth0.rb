Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    Rails.application.credentials[Rails.env.to_sym][:auth0][:auth0_client_id],
    Rails.application.credentials[Rails.env.to_sym][:auth0][:auth0_client_secret],
    Rails.application.credentials[Rails.env.to_sym][:auth0][:auth0_domain],
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid profile'
    }
  )
end