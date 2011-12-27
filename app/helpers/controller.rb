CobotFb.helpers do
  def auth
    @auth ||= Koala::Facebook::OAuth.new(Config[:fb_app_id], Config[:fb_app_key])
  end

  def oauth_client
    OAuth2::Client.new(Config[:cobot_app_id],
      Config[:cobot_app_key],
      site: 'https://cobot.me',
      token_url: '/oauth2/access_token',
      authorize_url: '/oauth2/authorize',
      raise_errors: false)
  end

  def get_oauth_session(space)
    oauth_session = OAuth2::AccessToken.new(oauth_client, space.token, scope: 'read signin')
    oauth_session.options[:header_format] = "OAuth %s"
    oauth_session
  end

  def get_space_id(space_url)
    space_url.match(/api\/spaces\/([\w-]+)/)[1]
  end

end