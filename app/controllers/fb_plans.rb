
CobotFb.controller  do
  # fb calling
  post '/plans' do
    signed_page_params = auth.parse_signed_request(params[:signed_request])["page"]
    fb_page_id = signed_page_params["id"]
    session[:fb_page_id] = fb_page_id
    redirect "/plans?fb_page_id=#{fb_page_id}"
  end

  get '/plans' do
    space = Space.find_by_fb_id! (params[:fb_page_id] || session[:fb_page_id])
    oauth_session = get_oauth_session(space.token)
    t1 = Thread.new{
      @space_json = oauth_session.get("http://www.cobot.me/api/spaces/#{space.space_id}").body
    }
    @plans_json = oauth_session.get("http://#{space.space_id}.cobot.me/api/plans" ).body
    t1.join
    render 'space/plans', layout: :facebook
  end
end