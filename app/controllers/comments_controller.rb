class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @task = Task.find(comment_params[:task_id])

    if @comment.save
      redirect_to @task
    else
      render @task, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.expect(comment: [ :text, :task_id, :user_id ])
  end
end
