class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
    @cities = City.all
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    if @task.user != Current.user
      redirect_to tasks_path
    end
  end

  # POST /tasks or /tasks.json
  def create
    # @task = Task.new(task_params)
    # @task.user = Current.user
    @task = Current.user.tasks.build(task_params) # kraca verzija ovog iznad
    if @task.save
      redirect_to @task
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
      if @task.update(task_params)
        redirect_to my_task_path(@task)
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    if @task.user == Current.user
      @task.destroy!
        redirect_to profile_path
    else
        redirect_to profile_path, status: :unauthorized
    end
  end

  def user_task
    @task = Task.find(params.expect(:task_id))
  end

  def my_task
    set_task
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.expect(task: [ :title, :description ])
    end
end
