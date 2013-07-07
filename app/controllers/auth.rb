CobotFb.controller  do
  get '/auth' do
    redirect oauth_client.auth_code.authorize_url(
      :redirect_uri => base_url+'/new',
      scope: 'read' #space sparated!
    )
  end
end