class UserMailer < ActionMailer::Base
  default :from => "no-reply@woojah.com"

  #
  # This method is called when user_sender wants to contact user_receiver
  # for a particular ad and user_receiver is the owner of the ad. It sends an
  # email to user_receiver telling him that he has been contacted for his ad by
  # user sender
  #
  def send_email(user_sender, user_receiver, ad, message = "")
    @user_sender = user_sender
    @user_receiver = user_receiver
    @ad = ad
    @message = message
    mail(:to => @user_receiver.email,:subject => "Clasifiteca | te han contactado por un anuncio");
  end


end
