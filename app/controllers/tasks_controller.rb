class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = filtered_tasks
    @cities = City.all
    @offers = filtered_offers
    @categories = TaskCategory.all
    @pagy_tasks, @tasks = pagy(@tasks, limit: 20, page_param: :tasks_page)
    @pagy_offers, @offers = pagy(@offers, limit: 10, page_param: :offers_page)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Current.user.tasks.build(task_params)
    if @task.save
      redirect_to profile_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    if @task.user != Current.user
      redirect_to tasks_path
    end
  end

  def update
      if @task.user == Current.user && @task.update(task_params)
        redirect_to profile_path
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    if @task.user == Current.user
      @task.destroy!
        redirect_to profile_path
    else
      respond_to do |format|
        format.html { redirect_to profile_path, status: :unauthorized }
      end
    end
  end

  private
    def set_task
      @task = Task.find_by(id: params.expect(:id))
      redirect_to tasks_path if @task.nil?
    end

    def task_params
      params.expect(task: [ :title, :description, :city_id, images: [] ])
    end

    def filtered_tasks
      city = City.select(:id).find_by(name: params[:city])
      category = TaskCategory.select(:id).find_by(name: params[:category])
      sort_field = case params[:sort_by]
      when "Oldest"
        { created_at: :asc }
      when "Newest"
        { created_at: :desc }
      when "Most offers"
        { offers_count: :desc }
      when "Fewest offers"
        { offers_count: :asc }
      else
        { created_at: :desc }
      end

      tasks = Task.where(completed: false).order(sort_field)
      tasks = tasks.where(city: city) if city
      tasks = tasks.where(task_category: category) if category

      tasks
    end

    def filtered_offers
      if Offer.statuses.include?(params[:offer_status])
        offers = Current.user.offers.where(status: params[:offer_status])
      else
        offers = Current.user.offers
      end
      offers.order(created_at: :desc)
    end
end
