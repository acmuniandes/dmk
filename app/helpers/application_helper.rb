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

  #
  # btn_text: button's text
  # title: the title of the modal
  # content: the modal's content wrapped inside <p></p> tags
  def render_modal(btn_text, title, content)
    render :partial => "widgets/bootstrap/modal_simple" , :locals => {:title => title, :content => content, :btn_text=>btn_text}
  end

end
