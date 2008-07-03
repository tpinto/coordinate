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
  
  $RESCUE_RESPONSE_CODES = {
  	'ActionController::RoutingError'             => 404,
  	'ActionController::UnknownAction'            => 404,
  	'ActiveRecord::RecordNotFound'               => 404,
  	'ActionController::InvalidAuthenticityToken' => 422
  }
  
  protected
  
  def set_event_var
    @event = Event.find_by_alias "barcamppt08"
  end

	# error logging
	def log_error(e)
		super(e) # this will log the exception to the log as fatal using the original log_error method from Rails
		# then we'll log the error into the database as well
		UserNotifier.deliver_send_error(e,"#{self.class.to_s}##{params[:action]}","#{request.env['REQUEST_METHOD']} #{request.env['REQUEST_URI']} #{request.env['SERVER_PROTOCOL']}",params.inspect) unless $RESCUE_RESPONSE_CODES[e.class.name] == 404
	end if ENV['RAILS_ENV'] != "development"
		
	def rescue_action(e)
		log_error(e)
		status_code = $RESCUE_RESPONSE_CODES[e.class.name]
		render_optional_error_file(status_code || 500)
	end if ENV['RAILS_ENV'] != "development"
end
