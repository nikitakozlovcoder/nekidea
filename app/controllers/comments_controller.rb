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

  def delete
  end

  private
  def comment_params
    pp params
    pp params.require(:comment).permit(:body)
  end

  def set_idea
    @idea = Idea.find(params[:idea_id]) unless params[:idea_id].nil?
  end
end
