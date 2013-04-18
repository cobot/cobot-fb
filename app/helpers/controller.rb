CobotFb.helpers do
  def auth
    @auth ||= Koala::Facebook::OAuth.new(CobotFb::Config[:fb_app_id], CobotFb::Config[:fb_app_key])
  end

  def oauth_client
    OAuth2::Client.new(CobotFb::Config[:cobot_app_id],
      CobotFb::Config[:cobot_app_key],
      site: 'https://cobot.me',
      token_url: '/oauth/access_token',
      authorize_url: '/oauth/authorize',
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