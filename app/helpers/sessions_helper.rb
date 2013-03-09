module SessionsHelper

  def get_user_id(request)
    return request.session[:user_id]
  end

end
