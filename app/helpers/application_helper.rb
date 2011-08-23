module ApplicationHelper
  
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end
  
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end
  
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def handle_messages
    html = <<-HTML
    HTML
    if flash[:error]
      html << <<-HTML
        <div class="alert-message error">
      		#{flash[:error]}
      	</div>
      HTML
    end
    if flash[:alert]
      html << <<-HTML
        <div class="alert-message warning">
      		#{flash[:alert]}
      	</div>
      HTML
    end
    if flash[:notice]
      html << <<-HTML
        <div class="alert-message info">
      		#{flash[:notice]}
      	</div>
      HTML
    end
    
    html.html_safe
  end
  
end
