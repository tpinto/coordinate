xml.instruct!

xml.rss "version" => "2.0" do
  xml.channel do
    xml.title       "Barcamp PT '08 - Novidades"
    xml.link        "http://barcamp.webreakstuff.com/"
    xml.description "As novidades do Barcamp Portugal 2008, trazidas até si pela magia da internet."

    @items.each do |item|
      xml.item do
        case item.class.to_s
        when "Comment"
          xml.title "Comentário à sessão '#{item.talk.title}'"
          xml.link "http://barcamp.webreakstuff.com/talks/#{item.talk_id}"
          xml.description item.body
          xml.guid "#{item.class.to_s.downcase}-#{item.id}-#{item.created_at.strftime("%d%m%Y%H%M%S")}"
        when "Talk"
          xml.title "Nova sessão proposta '#{item.title}'"
          xml.link "http://barcamp.webreakstuff.com/talks/#{item.id}"
          xml.description item.description
          xml.guid "#{item.class.to_s.downcase}-#{item.id}-#{item.created_at.strftime("%d%m%Y%H%M%S")}"
        when "Post"
          xml.title "Novidades! - #{item.title}"
          xml.link "http://barcamp.webreakstuff.com/"
          xml.description item.body
          xml.guid "#{item.class.to_s.downcase}-#{item.id}-#{item.updated_at.strftime("%d%m%Y%H%M%S")}"
        end
		    xml.pubDate(item.updated_at)
      end
    end

  end
end