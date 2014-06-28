class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  attr_reader :jawbone_access_token, :jawbone_client

  def jawbone
    current_user.update(
      jawbone_access_token: jawbone_access_token,
      jawbone_xid: jawbone_xid,
      first_name: jawbone_first_name,
      last_name: jawbone_last_name,
      weight: jawbone_weight,
      height: jawbone_height,
      age: jawbone_age,
      gender: jawbone_gender
    )
    if session[:jawbone_redirect_url]
      redirect_to session[:jawbone_redirect_url]
    else
      render text: 'No redirect url found'
    end
  end

  private

  def jawbone_access_token
    @jawbone_access_token ||= JSON.parse(RestClient.post('https://jawbone.com/auth/oauth2/token', client_id: ENV['JAWBONE_CLIENT_ID'], client_secret: ENV['JAWBONE_CLIENT_SECRET'], grant_type: 'authorization_code', code: params[:code]))['access_token']
  end

  def jawbone_client
    @jawbone_client ||= Jawbone::Client.new(jawbone_access_token)
  end

  def jawbone_xid
    jawbone_client.user['data']['xid']
  end

  def jawbone_first_name
    jawbone_client.user['data']['first']
  end

  def jawbone_last_name
    jawbone_client.user['data']['last']
  end

  def jawbone_weight
    jawbone_client.user['data']['weight']
  end

  def jawbone_height
    jawbone_client.user['data']['height']
  end

  def jawbone_age
    jawbone_client.trends['data']['data'].last.last['age']
  end

  def jawbone_gender
    if jawbone_client.user['data']['gender']
      'female'
    else
      'male'
    end
  end
end
