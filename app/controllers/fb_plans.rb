
CobotFb.controller  do

  # fb calling
  post '/plans' do
    signed_page_params = auth.parse_signed_request(params[:signed_request])["page"]
    fb_page_id = signed_page_params["id"]
    session[:fb_page_id] = fb_page_id
    if Space.find_by_fb_id(fb_page_id)
      redirect "/plans"
    else
      @admin = signed_page_params["admin"]
      render "space/new"
    end
  end

  get '/plans' do
    if params[:code] #we just authorized us
      oauth_session = oauth_client.auth_code.get_token(params[:code], :redirect_uri => 'https://cobot-fb.herokuapp.com/')
      oauth_session.options[:header_format] = "OAuth %s" # WTF? Don't work otherwise.
      user_info = JSON.parse(oauth_session.get("http://www.cobot.me/api/user").body)
      space_id = get_space_id(user_info['admin_of'].first['space_link'])
      space = Space.create!(space_id: space_id,  fb_id: session[:fb_page_id], token: oauth_session.token)
    else #we have a token
      space = Space.find_by_fb_id! session[:fb_page_id]
      oauth_session = get_oauth_session(space)
    end
    @space_json = oauth_session.get("http://www.cobot.me/api/spaces/#{space.space_id}").body
    @plans_json = oauth_session.get("http://#{space.space_id}.cobot.me/api/plans" ).body
    render 'space/plans'
  end
end