# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  before_filter :login_from_cookie
  before_filter :set_event_var # only because we're running only for one event: barcamp
  after_filter :store_location
  
  helper :all # include all helpers, all the time
  helper :microformats
  
  layout "twocols"

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '0815e64ca9c78e9381aa72c0d0b9eab6'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  
  protected
  
  def set_event_var
    @event = Event.find_by_alias "barcamppt08"
  end
end
