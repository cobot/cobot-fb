CobotFb.helpers do
  def auth
    @auth ||= Koala::Facebook::OAuth.new(CobotFb::Config[:fb_app_id], CobotFb::Config[:fb_app_key])
  end

  def base_url
    @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
  end

  def get_space_id(space_url)
    space_url.match(/api\/spaces\/([\w-]+)/)[1]
  end

  def render_plans(fb_page_id)
    cache_key request.path_info + '?fb_page_id=' + fb_page_id.to_s
    space = Space.find_by_fb_id! fb_page_id
    @space_id = space.space_id
    render 'space/plans', layout: :facebook
  end
end
