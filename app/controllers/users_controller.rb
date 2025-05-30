class UsersController < ApplicationController
  allow_unauthenticated_access only: [ :new, :create ]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params.expect(:id))
    @tasks = @user.tasks.where(completed: false).order(created_at: :desc)
    @tasks_completed = Task.where(assigned_to: @user, completed: true).count
    @average_price = @user.offers.average("price")&.round(1)
    @average_rating = @user.reviews.average("rating")&.round(1)
    @reviews = @user.reviews
    @pagy_reviews, @reviews = pagy(@reviews, limit: 10, page_param: :reviews_page)
    @pagy_tasks, @tasks = pagy(@tasks, limit: 20, page_param: :tasks_page)
  end

  def new
    @user = User.new
    @cities = City.all
  end

  def create
    city = City.find_by(name: user_params[:city])
    @user = User.new(user_params.except(:city).merge(city: city))

    if @user.save
      start_new_session_for @user
      redirect_to tasks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def profile
    @user = Current.user
    @tasks = @user.tasks.where(completed: false).order(created_at: :desc)
    @cities = City.all
    @tasks_completed = Task.where(assigned_to: @user, completed: true).count
    @average_price = @user.offers.average("price")&.round(1)
    @average_rating = @user.reviews.average("rating")&.round(1)
    @reviews = @user.reviews
    @pagy_reviews, @reviews = pagy(@reviews, limit: 10, page_param: :reviews_page)
    @pagy_tasks, @tasks = pagy(@tasks, limit: 20, page_param: :tasks_page)
  end

  def user_active_tasks
    @user = User.find(params.expect(:user_id))
    @tasks = @user.tasks.where(completed: false).order(created_at: :desc)
    @pagy, @tasks = pagy(@tasks, limit: 20)
  end

  def user_finished_tasks
    @user = User.find(params.expect(:user_id))
    @tasks = @user.tasks.where(completed: true).order(created_at: :desc)
    @pagy, @tasks = pagy(@tasks, limit: 20)
  end

  def update
    @user = Current.user
    city = City.find_by(name: user_params[:city])

    if @user.update(user_params.except(:city).merge(city: city))
      redirect_to profile_path
    end
  end

  private
  def user_params
    params.expect(user: [ :username, :email_address, :password, :city, :about_me ])
  end
end
