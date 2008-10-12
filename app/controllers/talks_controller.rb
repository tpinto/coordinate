class TalksController < ApplicationController
  before_filter :login_required, :except => [:show, :index]
  
  cache_sweeper :talk_sweeper, :only => [:create]

  def create
    @talk = Talk.new(params[:talk])
    
    return unless request.post?
    
    @talk.user = self.current_user
    @talk.event = @event
    @talk.save!
    
    flash[:message] = "Talk adicionada :)"

    redirect_to root_path
    
  rescue ActiveRecord::RecordInvalid
    
    flash.now[:title_errors] = @talk.errors.on(:title)
    
    render :action => "new"
  end
  
  def upload_asset
    @asset = Asset.new(params[:asset])
    @asset.talk_id = params[:id]
     if @asset.save
       flash[:notice] = 'Asset was successfully created.'
       redirect_to :action => :show, :id => params[:id]
     end
  end
  
  def index
    unless fragment_exist?("talks_page")
      @talks = Talk.find :all, :order => "id DESC"
    end
  end
  
  def show
    @talk = Talk.find(params[:id])
    
    render :layout => "textile_help"
  end
  
  def new
    render :layout => "textile_help"
  end
end
