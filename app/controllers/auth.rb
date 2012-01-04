CobotFb.controller  do
  get '/auth' do
    # we do oauth here
    redirect oauth_client.auth_code.authorize_url(
      :redirect_uri => 'https://cobot-fb.dev/',
      scope: 'read signin' #space sparated!
    )
  end
end