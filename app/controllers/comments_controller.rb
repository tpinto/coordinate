class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.talk_id = params[:id]
    @comment.user = current_user
    @comment.save
    
    redirect_back_or_default talk_path(@comment.talk)
    
  end
end
