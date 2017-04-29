def stub_space_response(space_id, attributes = {})
  proxy.stub("https://www.cobot.me:443/api/spaces/#{space_id}").and_return(
    headers: { 'Access-Control-Allow-Origin' => '*' },
    json: {name: "Stub Space", id: "space-#{space_id}", url: "http://#{space_id}.cobot.me", description: "A coworking space in Berlin Kreuzberg.", owner_id: "user-langalex", website: "http://co-up.de", time_zone_name: "Europe/Berlin", time_zone_offset: 1, country: "Germany", :'tax-rate' => 19.0, display_price: "gross"}.deep_merge(attributes.symbolize_keys)
  )
end

def stub_plans_response_for_space(space_id, plans = nil)
  proxy.stub("https://#{space_id}.cobot.me:443/api/plans").and_return(
    headers: { 'Access-Control-Allow-Origin' => '*' },
    json: (plans || [{
      name: "basic", price_per_cycle: "100.0", cycle_duration: 1, currency: "EUR", description: "basic plan",
      day_pass_price: "10.0", cancellation_period: 30, hidden: false,
      time_passes: []
    }])
  )
end
