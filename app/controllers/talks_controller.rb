class TalksController < ApplicationController
  before_filter :login_required, :except => [:show, :index]


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
  
  def index
    @talks = @event.talks
  end
  
  def show
    @talk = Talk.find(params[:id])
  end
  
  def new
  end

  def destroy
    @talk = Talk.find_by_id_and_user_id(params[:id],current_user.id)
    @talk.destroy
    
    flash[:message] = "Talk apagada :)"
    redirect_to root_path
  end
end
