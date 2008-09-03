xml.instruct!

xml.rss "version" => "2.0" do
  xml.channel do
    xml.title       "Barcamp PT '08"
    xml.link        "http://barcamp.webreakstuff.com/"
    xml.description "As novidades do Barcamp Portugal 2008, divulgadas pela magia da internet."

    @items.each do |item|
      xml.item do
        case item.class.to_s
        when "Comment"
          xml.title "Comentário à sessão '#{item.talk.title}'"
          xml.link "http://barcamp.webreakstuff.com/talks/#{item.talk_id}"
          xml.description item.body_html
          xml.guid "#{item.class.to_s.downcase}-#{item.id}-#{item.created_at.strftime("%d%m%Y%H%M%S")}"
          xml.author item.user.name
        when "Talk"
          xml.title "Nova sessão proposta '#{item.title}'"
          xml.link "http://barcamp.webreakstuff.com/talks/#{item.id}"
          xml.description item.description_html
          xml.guid "#{item.class.to_s.downcase}-#{item.id}-#{item.created_at.strftime("%d%m%Y%H%M%S")}"
          xml.author item.user.name
        when "Post"
          xml.title "Novidades! - #{item.title}"
          xml.link "http://barcamp.webreakstuff.com/"
          xml.description item.body_html
          xml.guid "#{item.class.to_s.downcase}-#{item.id}-#{item.created_at.strftime("%d%m%Y%H%M%S")}"
          xml.author "Barcamp Admin"
        end
		    xml.pubDate(item.updated_at.rfc2822)
      end
    end

  end
end