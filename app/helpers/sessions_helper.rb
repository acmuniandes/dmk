module SessionsHelper

  def get_user_id
    request.session[:user_id]
  end

  def is_signed_in
    request.session[:user_id] != nil
  end

end
