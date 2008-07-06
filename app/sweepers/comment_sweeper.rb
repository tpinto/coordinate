class CommentSweeper < ActionController::Caching::Sweeper
  observe Comment

  def after_create(comment)
    expire_page("/feed.xml")
  end

  def after_destroy(comment)
    expire_page("/feed.xml")
  end
  
  def after_update(comment)
    #expire_page("/feed.xml")
  end
end