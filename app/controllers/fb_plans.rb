
CobotFb.controller  do
  # fb calling
  post '/plans' do
    signed_page_params = auth.parse_signed_request(params[:signed_request])["page"]
    fb_page_id = signed_page_params["id"]
    session[:fb_page_id] = fb_page_id
    redirect "/plans?fb_page_id=#{fb_page_id}"
  end

  get '/plans', :cache => true do
    fb_page_id = (params[:fb_page_id] || session[:fb_page_id])
    cache_key "plans/#{fb_page_id}"
    space = Space.find_by_fb_id! fb_page_id
    @space_id =  space.space_id
    render 'space/plans', layout: :facebook
  end
end