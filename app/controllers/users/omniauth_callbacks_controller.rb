class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def jawbone
    token_url = 'https://jawbone.com/auth/oauth2/token'
    response = RestClient.post(token_url, client_id: ENV['JAWBONE_CLIENT_ID'], client_secret: ENV['JAWBONE_CLIENT_SECRET'], grant_type: 'authorization_code', code: params[:code])
    #TODO: store oauth key from response
    redirect_to session[:jawbone_redirect_url]
  end
end
