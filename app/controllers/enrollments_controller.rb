class EnrollmentsController < ApplicationController

  before_action :authenticate_user,  only: [:create]

  def new
    @enrollment = Enrollment.new
  end

  def create

    enroll = Enrollment.create(enroll_params)
    if enroll.save
      render json: {status: 200, msg: 'Enrollment was successful.'}
    else
      render json: enroll.errors, status: :unprocessable_entity
    end

  end

  private

  # Setting up strict parameters for when we add account creation.
  def enroll_params
    params.require(:enrollment).permit(:course_id, :user_id)
  end
end
