class OffersController < ApplicationController
  before_action :prevent_self_offer, only: %i[new create]

  def show
    @offer = Offer.find(params.expect(:id))
  end

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

  def edit
    @offer = Offer.find(params.expect(:id))
    redirect_to root_path if @offer.user != Current.user
  end

  def update
    @offer = Offer.find(params.expect(:id))
    if @offer.user == Current.user && @offer.update(offer_params)
      redirect_to profile_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @offer = Offer.find_by(id: params.expect(:id))
      if @offer.destroy
        redirect_to work_path
      end
  end

  def accept
    @offer = Offer.find(params[:id])
    if @offer.update_attribute(:status, "accepted") && @offer.task.update(assignee: @offer.user)
      respond_to do |format|
        format.html { redirect_to @offer.task }
        format.turbo_stream
      end
    end
  end

  def decline
    @offer = Offer.find(params[:id])
    if @offer.update_attribute(:status, "declined")
      respond_to do |format|
        format.html { redirect_to @offer.task }
        format.turbo_stream
      end
    end
  end

  def cancel
    @offer = Offer.find(params[:id])
    if @offer.update_attribute(:status, "pending") && @offer.task.update(assignee: nil)
      respond_to do |format|
        format.html { redirect_to @offer.task }
        format.turbo_stream
      end
    end
  end

  def complete
    @offer = Offer.find(params[:id])
    if @offer.update_attribute(:status, "completed") && @offer.task.update(completed: true)
      respond_to do |format|
        format.html { redirect_to @offer.task }
        format.turbo_stream
      end
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
