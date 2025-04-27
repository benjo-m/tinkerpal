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
        format.html { redirect_to root_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def profile
    @user = Current.user
  end

  private

  def user_params
    params.expect(user: [ :username, :email_address, :password ])
  end
end
