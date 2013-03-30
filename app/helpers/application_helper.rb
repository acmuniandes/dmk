module ApplicationHelper

  def render_disqus(url)
    render :partial => "widgets/disqus" , :locals => {:disqus_id => url}
  end

  def render_uservoice
    render "widgets/uservoice"
  end

  def render_header(title,subtitle, icon_name="")
    render :partial => "layouts/header" , :locals => {:title=>title, :subtitle => subtitle, :icon_name=> icon_name}
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
  def render_simple_modal(btn_text, title, content)
    render :partial => "widgets/bootstrap/modal_simple" , :locals => {:title => title, :content => content, :btn_text=>btn_text}
  end

  def render_modal(title, modal_id, &block)
    render :partial => "widgets/bootstrap/modal" , :locals => {:title => title,:modal_id=>modal_id,:content=>capture(&block)}
  end

  def render_modal_link(modal_id,&block)
    render :partial =>  "widgets/bootstrap/modal_link", :locals => {:modal_id=>modal_id, :content=>capture(&block)}
  end

end
