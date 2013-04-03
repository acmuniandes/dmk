module FacebookHelper

  def render_standard_like(url)
    render :partial => "widgets/fb/like", :locals => {:url => url}
  end

  def render_comments(url)
    render :partial => "widgets/fb/comments" ,:locals => {:url => url}
  end

end