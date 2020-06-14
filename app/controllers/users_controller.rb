class UsersController < ApplicationController
  # Using Knock to make sure the current_user is authenticated before completing request.
  before_action :authenticate_user,  only: [:index, :current, :update]
  before_action :authorize_as_admin, only: [:destroy]
  before_action :authorize,          only: [:update]
  before_action :set_user, only: [:courses]

  # if the current_user is authenticated.
  def index
    render json: {status: 200, msg: 'Logged-in'}
  end

  # Get all courses of logged-in user
  def courses
    all_courses_id = Enrollment.where(user_id: @user.id).pluck(:course_id)
    all_courses_names = Course.find(all_courses_id)
    render json: all_courses_names
  end

  # Get all users in the system
  def all
    all_users = User.all
    render json: all_users
  end

  # Call this method to check if the user is logged-in.
  # If the user is logged-in we will return the user's information.
  def current
    current_user.update!(last_login: Time.now)
    render json: current_user
  end


  # Method to create a new user using the safe params we setup.
  def create
    user = User.new(user_params)
    if user.save
      render json: {status: 200, msg: 'User was created.'}
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # Method to update a specific user. User will need to be authorized.
  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: { status: 200, msg: 'User details have been updated.' }
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # Method to delete a user, this method is only for admin accounts.
  def destroy
    user = User.find(params[:id])
    if user.destroy
      render json: { status: 200, msg: 'User has been deleted.' }
    end
  end

  private

  # Setting up strict parameters for when we add account creation.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def set_user
    @user = current_user
  end

  # Adding a method to check if current_user can update itself.
  # This uses our UserModel method.
  def authorize
    return_unauthorized unless current_user && current_user.can_modify_user?(params[:id])
  end
end
