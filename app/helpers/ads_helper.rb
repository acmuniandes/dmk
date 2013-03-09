module AdsHelper

  def render_ad(ad, edit_button=false)
    render :partial => "ads/ad_thumbnail" ,:locals => {:ad=>ad, :edit_button=>edit_button}
  end




end
