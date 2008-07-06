class UserSweeper < ActionController::Caching::Sweeper
  observe User

  def after_create(user)
    #expire_page("/index.xml")
    expire_fragment("home_users")
    expire_fragment("users_page")
  end

  def after_destroy(user)
    #expire_page("/index.xml")
    expire_fragment("home_users")
    expire_fragment("users_page")
  end
  
  def after_update(talk)
    #expire_page("/index.xml")
    expire_fragment("home_users")
  end
end