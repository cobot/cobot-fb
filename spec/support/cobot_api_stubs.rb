def stub_space_response(space_id, attributes = {})
  stub_request(:get, "http://www.cobot.me/api/spaces/#{space_id}").to_return(
    :status => 200,
    :body => {name: "Stub Space", id: "space-#{space_id}", url: "http://#{space_id}.cobot.me", description: "A coworking space in Berlin Kreuzberg.", owner_id: "user-langalex", website: "http://co-up.de", time_zone_name: "Europe/Berlin", time_zone_offset: 1, country: "Germany", :'tax-rate' => 19.0, display_price: "gross"}.deep_merge(attributes.symbolize_keys).to_json,
  )
end

def stub_plans_response_for_space(space_id, plans = nil)
  stub_request(:get, "http://#{space_id}.cobot.me/api/plans").to_return(
    :status => 200,
    :body => (plans || [{
      name: "basic", price_per_cycle: "100.0", cycle_duration: 1, currency: "EUR", description: "basic plan",
      day_pass_price: "10.0", cancellation_period: 30, hidden: false,
      time_passes: []
    }]).to_json
  )
end
