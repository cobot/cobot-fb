CobotFb.controller  do
  get '/auth' do
    # we do oauth here
    redirect oauth_client.auth_code.authorize_url(
      :redirect_uri => base_url,
      scope: 'read signin' #space sparated!
    )
  end
end