class UsersController < ApplicationController
  allow_unauthenticated_access only: [ :new, :create ]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params.expect(:id))
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

    if params[:tasks] == "completed"
      @tasks = Current.user.tasks.where(completed: true)
    elsif params[:tasks] == "active"
      @tasks = Current.user.tasks.where(completed: false)
    else
      @tasks = Current.user.tasks
    end

    @pagy, @tasks = pagy(@tasks, limit: 20)
  end

  private

  def user_params
    params.expect(user: [ :username, :email_address, :password ])
  end
end
