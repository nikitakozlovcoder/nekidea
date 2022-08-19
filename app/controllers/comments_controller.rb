class CommentsController < ApplicationController
  before_action :set_idea


  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.idea = @idea
    @saveres = @comment.save

    respond_to do |format|
      format.js
      format.html{
       redirect_to controller: 'ideas', action: 'show', id: @idea.id
      }

    end


  end

  def destroy
    @comment = Comment.find(params[:id])
    status = :forbidden

    unless @comment.can_be_deleted? current_user
      head status and return
    end


    if @comment.destroy
      status = :ok
    else
      status = :internal_server_error
    end

    respond_to do |format|
        format.json { head status  }
        format.html{ redirect_to controller: 'ideas', action: 'show', id: @comment.idea.id}
    end


  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_idea
    @idea = Idea.find(params[:idea_id]) unless params[:idea_id].nil?
  end
end
