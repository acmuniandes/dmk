module AdsHelper

  def render_ad(ad)
    render :partial => "ads/ad_thumbnail" ,:locals => {:ad=>ad}
  end




end
