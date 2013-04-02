module FacebookHelper

  def render_standard_like(url)
    render :partial => "widgets/fb/like", :locals => {:url => url}
  end


end