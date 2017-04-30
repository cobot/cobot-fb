Billy.configure do |c|  
  c.cache = true
  c.ignore_params = [
    'https://www.facebook.com/connect/ping',
  ]
  c.strip_query_params = true
  c.persist_cache = true
  c.cache_path = 'spec/req_cache/'
end

# need to call this because of a race condition between persist_cache

# being set and the proxy being loaded for the first time
Billy.proxy.reset_cache