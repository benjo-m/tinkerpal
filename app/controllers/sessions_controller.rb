class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }
  before_action :redirect_if_authenticated, only: [ :new, :create ]

  def new
  end

  def create
    # if user = User.authenticate_by(params.permit(:email_address, :password))
    if user = User.authenticate_by(params.permit(:username, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another username or password."
    end
  end

  def destroy
    terminate_session
    redirect_to login_path
  end

  private
  def redirect_if_authenticated
    if authenticated?
      redirect_to root_path
    end
  end
end
