Billy.configure do |c|  
  c.cache = true
end

# need to call this because of a race condition between persist_cache

# being set and the proxy being loaded for the first time
Billy.proxy.reset_cache