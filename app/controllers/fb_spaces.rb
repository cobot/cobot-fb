CobotFb.controller  do
  get '/new' do
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
      Space.create!(space_id: params[:space_id],  fb_id: params[:page_id])
    else
      redirect '/auth'
    end
  end
end