
CobotFb.controller  do
  # fb calling
  post '/plans', :cache => true do
    signed_page_params = auth.parse_signed_request(params[:signed_request])["page"]
    render_plans signed_page_params["id"]
  end

  get '/plans', :cache => true do
    render_plans params[:fb_page_id]
  end
end