module ApplicationHelper

  def render_disqus(url)
    render :partial => "widgets/disqus" , :locals => {:disqus_id => url}
  end

  def render_uservoice
    render "widgets/uservoice"
  end

  def render_header(title,subtitle)
    render :partial => "layouts/header" , :locals => {:title=>title, :subtitle => subtitle}
  end

  def render_if(condition,&code)
    if condition then
       return capture(&code)
    end
  end

end
