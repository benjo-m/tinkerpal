class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @task = Task.find(params.expect(:task_id))
  end

  def create
    @review = Review.new(review_params)
    @task = Task.find(params[:review][:task_id])
    @offer = Offer.accepted.find_by(task_id: @task.id)

    if @review.save && @task.update(completed: true) && @offer.update_attribute(:status, :completed)
    Offer.where.not(id: @offer.id).where(task_id: @task.id).update_all(status: :declined)
      respond_to do |format|
        format.html { redirect_to @task }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def review_params
    params.expect(review: [ :rating, :comment, :task_id, :user_id ])
  end
end
