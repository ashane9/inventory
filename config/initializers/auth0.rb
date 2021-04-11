puts "before config load"
AUTH0_CONFIG = Rails.application.config_for(:auth0)
puts "after config load"
puts Rails.application.credentials.auth0[:auth0_client_id]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    AUTH0_CONFIG['auth0_client_id'],
    AUTH0_CONFIG['auth0_client_secret'],
    AUTH0_CONFIG['auth0_domain'],
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid profile'
    }
  )
end