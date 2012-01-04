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
      
      URI.parse(current_url).to_s.should =~ %r{https://cobot.me/oauth2/authorize}
    end

    it "it displays apology to visitors" do
      @fb_request_params['page']['admin'] = false
      
      page.driver.post '/'
      
      page.should have_content 'Sorry'
    end
  end
end