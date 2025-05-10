class OffersController < ApplicationController
  before_action :prevent_self_offer, only: %i[new create]

  def new
    @task = Task.find(params[:task_id])
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @task = Task.find(offer_params[:task_id])

    if @offer.save
      redirect_to @offer.task
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept
    @offer = Offer.find(params[:id])
    if @offer.update(status: "accepted") && @offer.task.update(assignee: @offer.user)
      redirect_to @offer.task
    end
  end

  def decline
    @offer = Offer.find(params[:id])
    if @offer.update(status: "declined")
      redirect_to @offer.task
    end
  end

  def cancel
    @offer = Offer.find(params[:id])
    if @offer.update(status: "pending") && @offer.task.update(assignee: nil)
      redirect_to @offer.task
    end
  end

  private
  def offer_params
    params.expect(offer: [ :price, :note, :task_id, :user_id, :date, :time ])
  end

  def prevent_self_offer
    task = Task.find(params[:task_id])
    redirect_to task if task.user == Current.user
  end
end
