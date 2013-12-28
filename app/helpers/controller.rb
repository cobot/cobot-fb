CobotFb.helpers do
  def auth
    @auth ||= Koala::Facebook::OAuth.new(CobotFb::Config[:fb_app_id], CobotFb::Config[:fb_app_key])
  end

  def base_url
    @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
  end

  def oauth_client
    OAuth2::Client.new(CobotFb::Config[:cobot_app_id],
      CobotFb::Config[:cobot_app_key],
      site: 'https://www.cobot.me',
      token_url: '/oauth/access_token',
      authorize_url: '/oauth/authorize',
      raise_errors: false)
  end

  def get_oauth_session(token)
    oauth_session = OAuth2::AccessToken.new(oauth_client, token, scope: 'read signin')
    oauth_session.options[:header_format] = "OAuth %s"
    oauth_session
  end

  def get_space_id(space_url)
    space_url.match(/api\/spaces\/([\w-]+)/)[1]
  end

  def render_plans(fb_page_id)
    cache_key request.path_info + "?fb_page_id=" + fb_page_id.to_s
    space = Space.find_by_fb_id! fb_page_id
    @space_id =  space.space_id
    render 'space/plans', layout: :facebook
  end

end