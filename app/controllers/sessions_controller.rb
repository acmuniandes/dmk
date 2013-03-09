class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    user_id = nil
    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      user_id = @authorization.user.id
      #render :text => "Welcome back #{@authorization.user.nombre}! You have already signed up. "
      session[:user_id] = user_id
      redirect_to("/me")
    else

      user_name = auth_hash["extra"]["raw_info"]["first_name"]
      user_email = auth_hash["extra"]["raw_info"]["email"]

      user = User.new :name => user_name, :email => user_email
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]

      user.save
      user_id = user.id
      session[:user_id] = user_id
      redirect_to("/me");

    end


  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end

  def destroy
    session[:user_id] = nil
    render :text => "You've logged out!"
  end

end
