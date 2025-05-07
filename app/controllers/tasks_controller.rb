class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    filters = params.permit(:sort_by, :city)

    @tasks = Task.order(sort_field(filters[:sort_by]))

    if filters[:city]
      city = City.select(:id).find_by(name: filters[:city].capitalize)
      @tasks = @tasks.where(city_id: city.id) if city
    end

    @cities = City.all

    @pagy, @tasks = pagy(@tasks, limit: 20)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
    if @task.user != Current.user
      redirect_to root_path
    end
  end

  def create
    @task = Current.user.tasks.build(task_params)
    if @task.save
      redirect_to profile_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
      if @task.update(task_params)
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
        redirect_to profile_path, status: :unauthorized
    end
  end

  private
    def set_task
      @task = Task.find_by(id: params.expect(:id))
      redirect_to root_path if @task.nil?
    end

    def task_params
      params.expect(task: [ :title, :description, :city_id, images: [] ])
    end

    def sort_field(sort_by)
      case sort_by
      when "newest"
        { created_at: :desc }
      when "oldest"
        { created_at: :asc }
      else
        { created_at: :desc }
      end
    end
end
