class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all.order(created_at: :desc)
    @cities = City.all
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    if @task.user != Current.user
      redirect_to root_path
    end
  end

  # POST /tasks
  def create
    # @task = Task.new(task_params)
    # @task.user = Current.user
    @task = Current.user.tasks.build(task_params) # kraca verzija ovog iznad
    if @task.save
      redirect_to params[:return_to].presence || root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
      if @task.update(task_params)
        redirect_to profile_path
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /tasks/1
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
      params.expect(task: [ :title, :description, :city_id ])
    end
end
