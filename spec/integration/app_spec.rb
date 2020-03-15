# frozen_string_literal: true

require 'spec_helper'

describe 'user opens app the first time', type: :request do
  before(:each) do
    @fb_auth = stub_fb_auth
    @fb_request_params = { 'page' => { 'id' => '123' } }
    @fb_auth.stub(parse_signed_request: @fb_request_params)
  end

  describe 'from the app start page', type: :feature do
    it 'displays app is discontinues' do
      visit '/'
      expect(page).to have_content('We are sorry!')
    end
  end

  describe 'after it is setup on facebook', type: :feature, js: true do
    before(:each) do
      Space.create! space_id: 'test', fb_id: '123', token: 't0k3n'
      WebMock.allow_net_connect!
    end

    it 'shows the plans' do
      stub_space_response('test')
      @plan_hash = { name: 'My Plan', price_per_cycle: '100.0', cycle_duration: 1,
                     currency: 'EUR', description: 'basic plan',
                     day_pass_price: '10.0', cancellation_period: 30, hidden: false,
                     time_passes: [] }
      stub_plans_response_for_space('test', [@plan_hash])

      fake_fb_post

      page.should have_content 'My Plan'
    end
  end
end
