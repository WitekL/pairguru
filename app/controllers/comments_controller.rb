class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id

    if comment.save
      redirect_back(fallback_location: root_path, notice: 'Comment created') if comment.save
    else
      redirect_back(fallback_location: movies_path, alert: comment_errors(comment))
    end
  end

  def destroy
    comment = Comment.find(params[:id])

    if current_user == comment.user
      comment.destroy
      redirect_back(fallback_location: movies_path, notice: 'Comment succesfully deleted')
    else
      redirect_back(fallback_location: movies_path, alert: 'You are not the owner of this comment!')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :contents, :movie_id)
  end

  def comment_errors(comment)
    comment.errors.full_messages.to_sentence
  end
end
