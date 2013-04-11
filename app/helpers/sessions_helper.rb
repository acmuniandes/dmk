module SessionsHelper

  def get_user_id(request)
    return request.session[:user_id]
  end

  def is_signed_in
    return request.session[:user_id] != nil
  end

end
