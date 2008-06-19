module MicroformatsHelper
  
  # hcalendar("div#header")
  # hcalendar("div",{:id => "header"})
  def hcalendar(tag, opts = {}, &block)
    
  end
  
  def hcard(tag, &block)
    concat("<#{tag} class=\"vcard\">" + capture(self, &block) + "</#{tag}>", block.binding)
  end
  
  def photo(opts)
    "<img src=\"#{opts[:src]}\" class=\"photo\" />"
  end

  def name(fn, opts)
    if opts[:local_url]
      "<a href=\"#{opts[:local_url]}\" class=\"fn\">#{fn}</a> (<a href=\"#{opts[:url]||opts[:local_url]}\" class=\"url\">url</a>)"
    elsif opts[:url]
      "<a href=\"#{opts[:url]}\" class=\"fn url\">#{fn}</a>"
    else
      "<span class=\"fn\">#{fn}</span>"
    end
  end

end