class OffersController < ApplicationController
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

  private
  def offer_params
    params.expect(offer: [ :price, :note, :task_id, :user_id ])
  end
end
