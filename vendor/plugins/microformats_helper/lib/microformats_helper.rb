module MicroformatsHelper
    
  def hcard(str, &block)
    tag, id, klass = extract_tags(str)
    concat(render_tag(tag, id, "vcard #{klass}", capture(self, &block)), block.binding)
  end
  
  # hcalendar("tag#id.class")
  def hevent(str, &block)
    tag, id, klass = extract_tags(str)
    concat(render_tag(tag, id, "vevent #{klass}", capture(self, &block)), block.binding)
  end
  
  def hgeo(str, &block)
    tag, id, klass = extract_tags(str)
    concat(render_tag(tag, id, "geo #{klass}", capture(self, &block)), block.binding)
  end
  
  protected

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
  
  def url(text, href)
    "<a href=\"#{href}\" class=\"url\">" + text + "</a>"
  end
  
  def location(name, title)
    "<abbr title=\"#{title}\" class=\"location\">#{name}</abbr>"
  end
  
  def dtstart(name, title)
    "<abbr title=\"#{title}\" class=\"dtstart\">#{name}</abbr>"
  end
  
  def dtend(name, title)
    "<abbr title=\"#{title}\" class=\"dtend\">#{name}</abbr>"
  end
  
  def latitude(lat)
    "<span class=\"latitude\">#{lat}</span>"
  end
  
  def longitude(lon)
    "<span class=\"longitude\">#{lon}</span>"
  end
  
  private
  
  # matches "tag#id.class" (#hd and .class are optional)
  def extract_tags(str)
    str =~ /(\w+)(?:#(\w+))?(?:.(\w+))?/
    return $1,$2,$3
  end
  
  def render_tag(tag = "", id = nil, klass = nil, content = nil)
    if klass and id
      if content.nil?
        "<#{tag} class=\"#{klass}\" id=\"#{id}\" />"
      else
        "<#{tag} class=\"#{klass}\" id=\"#{id}\">#{content}</#{tag}>"
      end
    elsif klass
      if content.nil?
        "<#{tag} class=\"#{klass}\" />"
      else
        "<#{tag} class=\"#{klass}\">#{content}</#{tag}>"
      end
    elsif id
      if content.nil?
        "<#{tag} id=\"#{id}\" />"
      else
        "<#{tag} id=\"#{id}\">#{content}</#{tag}>"
      end
    else
      if content.nil?
        "<#{tag} />"
      else
        "<#{tag}>#{content}</#{tag}>"
      end
    end
  end

end