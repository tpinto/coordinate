class TalkSweeper < ActionController::Caching::Sweeper
  observe Talk

  def after_create(talk)
    expire_page("/feed.xml")
    expire_fragment("home_talks")
  end

  def after_destroy(talk)
    expire_page("/feed.xml")
    expire_fragment("home_talks")
  end
  
  def after_update(talk)
    expire_page("/feed.xml")
    expire_fragment("home_talks")
  end
end