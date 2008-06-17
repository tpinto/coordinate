module TalksHelper
  
  def delete_link(talk)
    link_to("delete", talk_url(talk), :method => :delete) if current_user == talk.user
  end
end
