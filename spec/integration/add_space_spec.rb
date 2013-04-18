require 'spec_helper'

describe "user opens app the first time", :type => :request do
  before(:each) do
    @fb_auth = stub_fb_auth
    @fb_request_params = {'page' => {'id' => '123'}}
    @fb_auth.stub(parse_signed_request: @fb_request_params)
  end

  describe "page is not yet know for space" do
    it "displays the auth link for the page admin and redirects to auth" do
      @fb_request_params['page']['admin'] = true

      page.driver.post '/'

      click_link 'Show plans on Facebook'

      URI.parse(current_url).to_s.should =~ %r{https://cobot.me/oauth/authorize}
    end

    it "it displays apology to visitors" do
      @fb_request_params['page']['admin'] = false

      page.driver.post '/'

      page.should have_content 'Sorry'
    end
  end

  describe "Page is know", :js => true do
    before(:each) do
      Space.create! space_id: 'test', fb_id: "123", token: 't0k3n'
      WebMock.disable_net_connect!(allow_localhost: true)
      stub_space_response('test')
      @plan_hash = {name: "basic", price_per_cycle: "100.0", cycle_duration: 1,
        currency: "EUR", description: "basic plan",
        day_pass_price: "10.0", cancellation_period: 30, hidden: false,
        time_passes: []
      }
    end

    it "shows the plans" do
      @plan_hash[:name] = 'My Plan'
      stub_plans_response_for_space('test', [@plan_hash])

      fake_fb_post

      page.should have_content 'My Plan'
    end

    it "don't show hidden plans" do
      @plan_hash.merge!(name: 'Hidden Plan', hidden: true)
      stub_plans_response_for_space('test', [@plan_hash])

      fake_fb_post
      page.should_not have_content 'Hidden Plan</h3>'
    end
  end
end