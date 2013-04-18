
CobotFb.controller  do
  get '/' do
    if params[:code] #we just authorized us
      oauth_session = oauth_client.auth_code.get_token(params[:code], :redirect_uri => base_url)
      session[:token] = oauth_session.token    
    end
    if session[:token]
      oauth_session = get_oauth_session(session[:token])
      user_info = JSON.parse(oauth_session.get("http://www.cobot.me/api/user").body)
      @spaces_json = user_info['admin_of'].to_json
      render "space/new"
    else
      redirect '/auth'
    end
  end
  
  post 'spaces' do
    if session[:token]
      Space.create!(space_id: params[:space_id],  fb_id: params[:page_id], token: session[:token])
    else
      redirect '/auth'
    end
  end
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
    space = Space.find_by_fb_id! session[:fb_page_id]
    oauth_session = get_oauth_session(space.token)
    @space_json = oauth_session.get("http://www.cobot.me/api/spaces/#{space.space_id}").body
    @plans_json = oauth_session.get("http://#{space.space_id}.cobot.me/api/plans" ).body
    render 'space/plans'
  end
end