# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :set_course, only: [:create]

  def index
    @courses = Course.includes(:tutors).all
    render json: MultiJson.dump(CoursePresenter.list(@courses)), status: :ok
  end

  def create
    form = CourseForm.new(@course, course_params)
    if form.valid?
      @course = CreateCourse.call(form.attributes).course
      render json: MultiJson.dump(CoursePresenter.single(@course)), status: :ok
    else
      render json: form.errors, status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, tutors: %i[name email])
  end

  def set_course
    @course = Course.new
  end
end
