
CobotFb.controller  do

  post '/' do
    fb_page_id = auth.parse_signed_request(params[:signed_request])["page"]["id"]
    session[:fb_page_id] = fb_page_id
    unless space = Space.find_by_fb_id(fb_page_id)
      link_to('Get my membership plans on FB', '/space/new').to_s
    else
      redirect "/"
    end
  end

  get '/' do
    if params[:code] #we just authorized us
      oauth_session = oauth_client.auth_code.get_token(params[:code], :redirect_uri => 'https://cobot-fb.dev/')
      oauth_session.options[:header_format] = "OAuth %s" # WTF? Don't work otherwise.
      user_info = JSON.parse(oauth_session.get("http://www.cobot.me/api/user").body)
      space_id = get_space_id(user_info['admin_of'].first['space_link'])
      space = Space.create!(space_id: space_id,  fb_id: session[:fb_page_id], token: oauth_session.token)
    else #we have a token
      space = Space.find_by_fb_id! session[:fb_page_id]
      oauth_session = get_oauth_session(space)
    end
    @plans_json = oauth_session.get("http://#{space.space_id}.cobot.me/api/plans" ).body
    render 'spaces/space'
  end
end