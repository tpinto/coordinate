module EventsHelper
  
  def hcalendar(opts = {})
    o = {:html => {:tag => "span"}}
    
    o.update(opts)
    
    "<#{o[:html][:tag]} class=\"vcalendar\">" +
    (o[:alink] ? "<a href=\"#{o[:alink]}\" class=\"fn\">#{o[:fn]}</a> (<a href=\"#{o[:url]}\" class=\"url\">url</a>)" : "<a href=\"#{o[:url]}\" class=\"url fn\">#{o[:fn]}</a>") +
    "</#{o[:html][:tag]}>"
    
  end
  
  def hcard(opts = {})
    o = {:html => {:tag => "span", :class => ""}}
    
    o.update(opts)
    
    "<#{o[:html][:tag]} class=\"vcard\">" +
    (o[:alink] ? "<a href=\"#{o[:alink]}\" class=\"fn\">#{o[:fn]}</a> (<a href=\"#{o[:url]}\" class=\"url\">url</a>)" : "<a href=\"#{o[:url]}\" class=\"url fn\">#{o[:fn]}</a>") +
    "</#{o[:html][:tag]}>"
  end
end
