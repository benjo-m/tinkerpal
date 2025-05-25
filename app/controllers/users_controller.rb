class UsersController < ApplicationController
  allow_unauthenticated_access only: [ :new, :create ]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params.expect(:id))
    @tasks = tasks(@user)
    @tasks_completed = Task.where(assigned_to: @user, completed: true).count
    @average_price = @user.offers.average("price")&.round(1)
    @average_rating = @user.reviews.average("rating")&.round(1)
    @reviews = @user.reviews
    @pagy, @tasks = pagy(@tasks, limit: 20)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        start_new_session_for @user
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def profile
    @user = Current.user
    @tasks = tasks(@user)
    @cities = City.all
    @tasks_completed = Task.where(assigned_to: @user, completed: true).count
    @average_price = @user.offers.average("price")&.round(1)
    @average_rating = @user.reviews.average("rating")&.round(1)
    @reviews = @user.reviews
    @pagy, @tasks = pagy(@tasks, limit: 20)
  end

  def update
    @user = Current.user
    city = City.find_by(name: user_params[:city].capitalize)

    if @user.update(user_params.except(:city).merge(city: city))
      redirect_to profile_path
    end
  end

  private
  def tasks(user)
    if params[:tasks] == "completed"
      @tasks = user.tasks.where(completed: true).order(created_at: :desc)
    else
      @tasks = user.tasks.where(completed: false).order(created_at: :desc)
    end
  end

  def user_params
    params.expect(user: [ :username, :email_address, :password, :city, :about_me ])
  end
end
