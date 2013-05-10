
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
    layout :facebook 
    space = Space.find_by_fb_id! session[:fb_page_id]
    oauth_session = get_oauth_session(space.token)
    @space_json = oauth_session.get("http://www.cobot.me/api/spaces/#{space.space_id}").body
    @plans_json = oauth_session.get("http://#{space.space_id}.cobot.me/api/plans" ).body
    render 'space/plans'
  end
end