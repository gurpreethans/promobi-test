# frozen_string_literal: true

class CourseForm
  include ActiveModel::Model

  attr_accessor :name, :tutors

  validates :name, presence: true
  validate :tutor_attributes

  def initialize(course, params = {})
    @name = params[:name] || course.name
    @_tutors = params[:tutors] || []
    @tutors = []
  end

  def attributes
    {
      name:,
      tutors: @tutors
    }
  end

  def tutor_attributes
    @_tutors.each do |param|
      form = TutorForm.new(Tutor.new, param)
      if form.valid?
        @tutors << form.attributes
      else
        errors.add(:tutors, form.errors.messages)
        break
      end
    end
  end
end
