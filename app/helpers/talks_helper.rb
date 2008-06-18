module TalksHelper
  
  def delete_link(talk)
    link_to("delete?", talk_url(talk), :method => :delete, :confirm => "De certeza que pretende apagar esta talk?") if current_user == talk.user
  end
end
