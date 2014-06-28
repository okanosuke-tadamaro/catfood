class SessionsController < Devise::SessionsController
  def new
    session[:jawbone_redirect_url] = params[:redirect_url]
    super
  end
end
