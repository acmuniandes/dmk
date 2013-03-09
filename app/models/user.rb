class User < ActiveRecord::Base
  attr_accessible :email, :name

  attr_accessible :email, :name
  has_many :authorizations
  has_many :ads

  #
  #Returns the fb url of the picture associated with this user. The url has the following form https://graph.facebook.com/#{id}/picture?width=#{width}
  #<b>Params</b>
  #<i>width</i> is the width of the picture
  #
  def get_fb_picture(width=30)
    return "https://graph.facebook.com/#{authorizations.first.uid}/picture?width=#{width}"
  end

end
