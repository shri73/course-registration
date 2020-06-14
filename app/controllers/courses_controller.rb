class CoursesController < ApplicationController
  before_action :authenticate_user,  only: [:index]
  def index
    courses = Course.all
    render json: courses
  end
end
