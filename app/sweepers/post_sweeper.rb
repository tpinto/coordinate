class PostSweeper < ActionController::Caching::Sweeper
  observe Post

  def after_create(post)
    expire_page("/feed.xml")
    expire_fragment("home_intro")
  end

  def after_destroy(post)
    expire_page("/feed.xml")
    expire_fragment("home_intro")
  end
  
  def after_update(post)
    expire_page("/feed.xml")
    expire_fragment("home_intro")
  end
end